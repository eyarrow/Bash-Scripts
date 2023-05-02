################################################################################
#
#	Part of the job management automation project
# 	Automates archiving a job listing and adding a reason for the archival
#	Archives to $HOME/jobs/Archived
# 
# 	@Parameters:
# 	$1 -> Name of the Folder to be archived (string)
#	$2 -> Reason for archiving the listing (string)
#
#
################################################################################

#!/bin/bash -x
set -eu 

# Archive job listing after the job has been closed.
# Move the folder structure to the Archive Folder
function moveFiles() {
	mv "$HOME/jobs/$1" "$HOME/jobs/Archived/$1"
	local folder="$HOME/jobs/Archived/$1"
	echo "$folder"
}

# Append the reason for closing the file to the jobdescription file
function appendCloseReason() {
	local todaysDate=`date +%m-%d-%Y`
	jobDescripPath=$('find' $2 '-name' 'jobdescription.txt')
	sed -i '1i Reason for Close: ' $jobDescripPath
	sed -i "2i ${todaysDate}" $jobDescripPath
	sed -i "3i ${1}" $jobDescripPath
}

function main() {
	path=$(moveFiles "$1")
	closeReason="$2"
	appendCloseReason "$closeReason" "$path"
}

main "$@"
