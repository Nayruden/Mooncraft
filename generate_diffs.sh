#!/bin/sh

rm -rf diffs/*.java
for f in orig/*.java
do
    filename=$(basename $f)
    if [ -f "src/$filename" ]
    then
        diff -uw orig/$filename src/$filename > diffs/$filename
    fi
done
