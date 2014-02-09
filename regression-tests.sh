#!/bin/bash

C=2
GREP='.'
if [ $# -eq 1 ]
then
    C=$1
    GREP='[*#/]'
fi

sh wiki-tests.sh Regression nob eng update | grep -C $C "$GREP"


