#!/bin/sh
draw() {
  ~/.config/lf/draw_img.sh "$@"
  exit 1
}

hash() {
  printf '%s/.cache/lf/%s' "$HOME" \
    "$(stat --printf '%n\0%i\0%F\0%s\0%W\0%Y' -- "$(readlink -f "$1")" | sha256sum | awk '{print $1}')"
}

cache() {
  if [ -f "$1" ]; then
    draw "$@"
  fi
}

file="$1"
shift

if [ -n "$FIFO_UEBERZUG" ]; then
  case "$(file -Lb --mime-type -- "$file")" in
    image/*)
      orientation="$(identify -format '%[EXIF:Orientation]\n' -- "$file")"
      if [ -n "$orientation" ] && [ "$orientation" != 1 ]; then
        cache="$(hash "$file").jpg"
        cache "$cache" "$@"
        convert -- "$file" -auto-orient "$cache"
        draw "$cache" "$@"
      else
        draw "$file" "$@"
      fi
      ;;
    video/*)
      cache="$(hash "$file").jpg"
      cache "$cache" "$@"
	  ffmpeg -y -i "$file" -vframes 1 "$cache"
      draw "$cache" "$@"
      ;;
    # application/pdf)
    #   cache="$(hash "$file")"
    #   cache "${cache}.jpg"
    #   pdftoppm -f 1 -l 1 \
    #       -scale-to-x 1920 \
    #       -scale-to-y -1 \
    #       -singlefile \
    #       -jpeg \
    #       -- "$file" "$cache"
    #   draw "${cache}.jpg"
    #   ;;
    *)
    # text/* | */xml)
      bat --terminal-width "$3" -f "$file"
	  ;;
  esac
fi

file -Lb -- "$1" | fold -s -w "$width"
exit 0
