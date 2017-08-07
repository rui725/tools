#!/bin/bash
# Created by Rui Rafael Rosillas
# Runs Shell scripts that I have created

function warning() {
    case $1 in
        1) echo $'\n'"too many arguements found"
           echo "example: . run.sh optional [directory name]"
           echo "default directory is current directory"$'\n'
	       return ;;
		2) echo $'\n'"directory not found"$'\n';;
		3) echo $'\n'"successfully loaded shell scripts start using commands"
		   echo "    -h for help and display commands"
		   echo "    -e to exit run.sh"$'\n';;
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
    #assign files
    arrayFile=$1
	echo $'\n'
	echo "Here is the list of all commands available enjoy!!"
	
	#print out files
    for f in ${arrayFile[@]}; do
	    fil=$( basename $f )
		let size=${#fil}-3
	    echo "     "${fil:0:$size} $'\t' "-"
    done
}

function loadFiles(){
    #sets directory
    currentDir=$1
    # sets find to search .sh files within directory
	allFiles=`find $currentDir -name "*.sh"`
	
	#check if it finds scripts
    if [ -z "$allFiles" ]; then
	    echo "No scripts found"
		return 1
	fi
	
	#sets the files into array
    arrayFile=( $allFiles )
	
	#removes run.sh command
	for (( i=0;i<${#arrayFile[@]};i++ )); do
		if [[ ${arrayFile[$i]} =~ .*run.sh.* ]]; then
			unset arrayFile[$i]
		fi
		
	done
	#sets the value removing the run.sh script
	arrayFile=( "${arrayFile[@]}" )

	#this means scripts loaded successfully
	warning 3
	
	#assign to global variable
	files=${arrayFile[@]}
	#for f in $files; do
	#	source $f
	#done
	return 0
}

function executeCommand(){
    
	for f in $files; do
	    if [[ $f = *"$1.sh"* ]]; then
			 sh $f ${@:2} 
		fi
	done
}



function checkCommand(){
    #assign command
	command=$1
	if [[ " ${files[*]} " == *"$command.sh"* ]]; then
		executeCommand $@
	else
	    echo "Invalid Command / Command not found"
	fi
	

}

function run_coms(){
	
	#set array of files
    arrayFile=$1
	
	#loops through user input commands
	while [ 1 ]; do
		read command
		firstCommand=`expr "$command" : '^\(.[a-z]*\)'`
		
		if [ $firstCommand = "-h" ]; then
		    displayCommands $arrayFiles;
		elif [ $firstCommand = "-e" ]; then
		    return
		else
		    checkCommand $command
		fi
	done

}


function main(){

	#initialize current directory
	currentDir="."
	
	#checks argument
	if [ $# = 1 ]; then
		#checks directory
		if testDirectory $1; then
			currentDir=$1
		else
			warning 2
			return
		fi
	elif [ $# -gt 1 ]; then
		warning 1
		return
	fi
    
	#loads files
	if loadFiles $currentDir; then
		#run commands
		run_coms $files
	fi
}

#start program
files=''
main $@









