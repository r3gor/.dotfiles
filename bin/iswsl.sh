#!/bin/bash

if [[ $(grep -i Microsoft /proc/version) ]]; then
    echo 1
else
    echo 0
fi


