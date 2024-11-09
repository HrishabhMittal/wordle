#!/bin/bash
echo -e "\033[H\033[0JPlay Wordle!"
list="list.txt"
if [[ "$1" == "-ny" ]]; then
    list="nylist.txt"
fi
word=$(shuf -n 1 $list)
yellow="\\\\033[33m"
green="\\\\033[32m"
reset="\\\\033[0m"
iter=""
while [[ "$iter" -ne "111111" ]]; do
    read -p "" guess
    echo -e "\033[1A\033[0J\033[1A"
    if [[ "${#guess}" -ne "5" ]]; then continue; fi
    isValid=$(cat list.txt | grep $guess)
    if [[ "$isValid" != "" ]]; then
        out="000111222333444"
        for i in {0..4}; do
            if [[ "${word:i:1}" == "${guess:i:1}" ]]; then
                out=$(echo "$out" | sed "s|$i$i$i|$green${guess:i:1}|")
            else
                for j in {0..4}; do 
                    if [[ "${word:i:1}" == "${guess:j:1}" ]]; then
                        out=$(echo "$out" | sed "s|$j$j$j|$yellow${word:i:1}|")
                        break
                    fi
                done
            fi
        done
        for i in {0..4}; do 
            out=$(echo "$out" | sed "s|$i$i$i|$reset${guess:i:1}|")
        done
        echo -e "$out\033[0m"
        iter="1$iter"
    fi
    if [[ "$guess" == "$word" ]]; then
        echo Congrats! you won!
        break
    fi
done
if [[ "$iter" == "11111" ]]; then
    echo boo you lost!
fi
