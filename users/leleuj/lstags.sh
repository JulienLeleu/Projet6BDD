#!/bin/bash

chemin=$HOME/tags;
patterns=$(sed "s/ /|/g" <<< $@);

stat -c"%i %n" $(find $chemin -type f)| egrep "$patterns" | sort -n | uniq -w9
