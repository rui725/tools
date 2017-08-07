#!/bin/bash
# Created by Rui Rafael Rosillas
# GitHub: rui725

function copy_warning(){
    case $1 in
	    1) echo "directory required"
		   echo "example: . copy.sh [from directory or file] optional [to directory or file]"
		   echo "default [to directory or file] is current directory"$'\n';;
		2) echo "not recognized as directory or file"$'\n'
	esac
}

function copy(){
	#checks arguements
	if [[ $# = 1 || $# = 2 ]]; then
		dirFrom=$1
	else
		copy_warning 1
		return
	fi

	if ! [[ -d $dirFrom || -f $dirFrom ]]; then
		copy_warning 2
		return
	fi
	
}

copy ${@:1}

function countArgs(){
    echo $#
}

