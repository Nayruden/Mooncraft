#!/bin/sh

for f in diffs/*.java
do
    filename=$(basename $f)
    if [ -f "orig/$filename" ]
    then
        patch -Nup0 -r toremove  < diffs/$filename
        rm -f toremove
    fi
done
