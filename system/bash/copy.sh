#!/bin/bash
# Created by Rui Rafael Rosillas
# GitHub: rui725

function copy{

#checks arguements
if [ $# != 0 && $# -lt 2]; then
    dirFrom = $1
else
	echo "directory required"
	echo "example: . copy.sh [from directory or file] optional [to directory or file]"
	echo "default [to directory or file] is current directory"
fi

if [ !-d $dirFrom ]; then
    echo "input directory or file required"
fi
}



function countArgs{
    echo $#
}

