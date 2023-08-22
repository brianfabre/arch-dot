#!/bin/sh

maim -so | tesseract stdin stdout -l eng | xclip -in -selection clipboard
