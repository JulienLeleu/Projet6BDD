#!/bin/bash

numeroInode=$1;
chemin=$HOME/tags/*;
find $chemin -inum $numeroInode | head -n1;
