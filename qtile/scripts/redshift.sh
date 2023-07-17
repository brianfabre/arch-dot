#!/bin/bash
# A script that asks the user for a temperature and use that to update redshift temperature in linux

# Ask the user for a temperature in Kelvin
# read -p "Enter a temperature in Kelvin: " temp
# temp=$(echo "" | dmenu -p "Enter a temperature in Kelvin: ")
temp=$(echo -e "6500\n6000\n5500\n5000\n4500\n4000\n3500\n3000\n2500\n2000" | rofi -async-pre-read 1 -dmenu)

# Check if the input is a valid number
if [[ $temp =~ ^[0-9]+$ ]]; then
  # Update the redshift temperature using the -O option
  redshift -P -O $temp
  # Display a confirmation message
  notify-send "Redshift temperature updated to $temp K."
else
  # Display an error message
  notify-send "Invalid input. Temperature unchanged."
fi

