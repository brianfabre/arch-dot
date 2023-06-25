#!/bin/sh

maim -s | tesseract stdin stdout -l eng | xclip -in -selection clipboard
