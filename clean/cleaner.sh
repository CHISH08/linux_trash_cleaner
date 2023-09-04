#!/bin/bash
fil=$HOME/.clean1/conf.txt
while IFS= read -r line; do
    if [[ "$line" == "Yes" || "$line" == "yes" || "$line" == "no" || "$line" == "No" ]]
    then
        yn=$line
    elif [[ "$line" == *"$HOME"* ]]
    then
        cln=$line
    else
    	star=$line
    fi
done < $fil
$HOME/.clean/fdupes-2.1.2/fdupes -d -N -r -A "$cln"
find "$cln" -type f -empty -exec rm -r {} \;
find "$cln" -type d -empty -print0 | while read -d $'\0' go
do
    if [[ "$go" != *"/clean"* && "$go" != *"/.clean"* && "$go" != *"/Изображения"* && "$go" != *"/Загрузки"* ]]
    then
        rmdir "$go"
    fi
done
if [[ $yn == "Yes" || $yn == "yes" ]]
then
    find "$cln" -type f -atime "$star" -print0 | while read -d $'\0' f
    do
        n=1
        if [[ "$f" != *"$HOME"* ]]
            then
            n=0
            continue
            fi
        while read y
        do
            if [[ "$f" == *"$y"* || "$f" == "$cln" || "$f" == *"/."* ]]
            then
            n=0
            break
        fi
        done < $HOME/.clean1/not.txt
        if [[ $n == 1 ]]
        then
            nu=1
            k="$f"
            if [[ "$k" !=  *"."* && "$k" ==  *"/"* ]]
            then
                nu=0
                continue
            fi
            while [[ "$k" ==  *"."* ]]
            do
                if [[ "$k" !=  *"."* && "$k" ==  *"/"* ]]
                then
                    nu=0
                    break
                fi
                k="$(echo "$k" | cut -f 2- -d '.')"
            done
            if [[ $nu == 0 ]]
            then
                continue
            fi
            if [ ! -d "$HOME/.clean/rub/$k" ]; then
                mkdir $HOME/.clean/rub/"$k"
            fi
            mv "$f" $HOME/.clean/rub/"$k"
        fi
    done
fi