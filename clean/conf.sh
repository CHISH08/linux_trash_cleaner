#!/bin/bash
read -p "Какую папку вы хотите почистить(полный путь к ней); Если вы ее уже вводили и не хотите менять, введите 0: " cln
read -p "Надо ли вам чистить старые файлы(Yes или No): " yn
read -p "Введите насколько долго неиспользуемые файлы вам надо удалить(введите в кол-во дней, если меньше указанного срока, напишите в начале -, иначе +): " star
chmod +x $HOME/.clean
if [[ "$cln" != 0 ]]
then
if [ ! -d "$HOME/.clean1" ]; then
   mkdir $HOME/.clean1
fi
if [ ! -d "$HOME/.clean/rub" ]; then
   mkdir $HOME/.clean/rub
fi
echo "$cln" > $HOME/.clean1/conf.txt
echo "$yn" >> $HOME/.clean1/conf.txt
echo "$star" >> $HOME/.clean1/conf.txt
fi
read -p "Какие папки вы бы хотели не трогать, введите полный путь к ним, чтобы избежать проблем, при совпадающих названиях(Когда закончите ввод введите 0)? Если вы хотите дозаполнить напишите 1 " i
n=0
if [[ $i == 1 ]]
then
n=$n+1
else
   echo ".d
.tab
.h
.py
.c
.cpp
.xsh
.md
.fish
.kml
.ipynb
.ps1
.csh
.html
.tpl
.pyi
.xsl
.pyc
.cfg
.pxd
.xml
.in
.o
.ko
.obj
.elf
.ilk
.map
.exp
.log
.gch
.pch
.lib
.a
.la
.lo
.dll
.so
.so.
.dylib
.exe
.out
.app
.i*86
.x86_64
.hex
.dSYM/
.su
.idb
.sh
.pdb
.mod
.cmd
.tmp_versions/
modules.order
Module.symvers
Mkfile.old
.conf
.yml" > $HOME/.clean1/not.txt
fi
while [ $i != 0 ]
do
   if [[ $i != 1 ]]
   then
   echo "$i" >> $HOME/.clean1/not.txt
   fi
   read -p "Какие папки вы бы хотели не трогать(Когда закончите ввод введите 0)? " i
done
echo "HOME=\"$HOME\""> $HOME/.clean1/cronin.txt
echo "0 0 1 * * $HOME/.clean/cleaner.sh; \$HOME" >> $HOME/.clean1/cronin.txt
echo "Не пугайтесь, это была всеволишь установка настроек!"
#set -e && sudo apt-get install
#set -e && sudo apt-get install cron
#set -e && sudo crontab $HOME/.clean1/cronin.txt
#set -e && apt-get install
#set -e && apt-get install cron
set -e && crontab $HOME/.clean1/cronin.txt