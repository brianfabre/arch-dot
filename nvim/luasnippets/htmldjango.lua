return {
    -- parse("div", [[<div class="$1">$2</div>]]),
    -- parse("tag-html", [[<$1>\n$2\n</$1>]]),
    parse({ trig = "div", wordTrig = true }, '<div class="$1">\n\t${2:$SELECT_DEDENT}\n</div>'),
    parse({ trig = "tag-html", wordTrig = true }, "<$1>\n\t${2:$SELECT_DEDENT}\n</$1>"),
}
