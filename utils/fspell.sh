#!/bin/bash

# Concatenate all the operands into a single string
input=$(IFS=" "; echo "$*")

# Pipe the concatenated string to aspell -a for spell checking
aspell -a <<< "$input"

# alternative invocation, get grep to get rid of i am really aspell message and blank lines
# # Loop through each word provided as an argument
# for word in "$@"
# do
#     # Spell check each word using aspell
#     # aspell -a <<< "$word"
#     aspell -a <<< "$word" | grep -v 'but really' | grep -v ^$
# done
