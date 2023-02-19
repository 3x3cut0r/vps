#!/bin/bash
var="en_US.UTF-8"

# set arg
if [ "$1" ]; then
    var=$1
else
    read -p "locale: (en_US.UTF-8): "
    if [ ! -z $REPLY ]; then
        var=$REPLY;
    fi
fi

# check $var is valid locale
if [[ ! $(cat /etc/locale.gen | grep $var) ]]; then
    echo "$var not in /etc/locale.gen"
    exit 1
fi

# prepare /etc/locale.gen
for line in "$(cat /etc/locale.gen | grep -v '#' | grep -v -e '^$')"; do
    sed -i "s/$line/\#\ $line/g" /etc/locale.gen
done
for line in "$(cat /etc/locale.gen | grep $var)"; do
    linenr=$(awk "/$line/{ print NR; exit }" /etc/locale.gen)
    sed -i -E "$linenr s/\#\ //g" /etc/locale.gen
done

# locale-gen
locale-gen $var

# export locale
export LANGUAGE=$var
export LANG=$var
export LC_ALL=$var
sed -i '/export\ LANGUAGE=/d' /etc/environment
echo "export LANGUAGE=$var" >> /etc/environment
sed -i '/export\ LANG=/d' /etc/environment
echo "export LANG=$var" >> /etc/environment
sed -i '/export\ LC_ALL=/d' /etc/environment
echo "export LC_ALL=$var" >> /etc/environment

# echo user instruction
echo -e "\nyou now have to logout and login again!"
