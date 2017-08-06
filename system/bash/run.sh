#!/bin/bash
# Created by Rui Rafael Rosillas
# Runs Shell scripts that I have created

function warning() {
    case $1 in
        1) echo "too many arguements found"
           echo "example: . run.sh optional [directory name]"
           echo "default directory is current directory"
	   return ;;
	2) echo "directory not found";;
	3) echo "successfully loaded shell scripts start using commands"
	   echo "    -h for help and display commands"
	   echo "    -e to exit run.sh" ;;
	100) return;;
    esac
}

function testDirectory() {
    if [ -d $1 ]; then
        return 0
    fi
    return 1
}

function displayCommands() {
    echo $1
}

#initialize current directory
currentDir="*"

#checks arguement
if [ $# = 1 ]; then
	#checks directory
	if testDirectory $1; then
		currentDir=$1/*
	else
		warning 2
		return
	fi
elif [ $# -gt 1 ]; then
    warning 1
    return
fi

#retrieves files
arrayFile=( $currentDir.sh )

#removes run.sh command
for (( i=0;i<${#arrayFile[@]};i++ )); do
    echo ${arrayFile[$i]}
    if [ ${arrayFile[$i]} = "run.sh" ]; then
	    unset arrayFile[$i]
	    arrayFile=( "${arrayFile[@]}" )
    fi
done

#this means scripts loaded successfully
warning 3

read command

while [ $command != '-e' ]; do
	case $command in 
		-h) displayCommands $arrayFile;;
	esac
	read command
done
