#!/bin/bash
#
# Dialy_Archive - Archive designated files & directories
######################################################################
#
# Gather Current Data
#
today=$(date +%Y-%m-%d)
#
# Set Archice File Name
#
backupFile=archive$today.tar.gz
#
# Set Configuration and Destination File
#
config_file=/archive/Files_To_Backup.txt
destination=/archive/$backupFile
#
######################## Main Script #################################
#
if [ -f $config_file ]
then 
    echo 
else
    echo 
    echo "$config_file dose not exit"
    echo "Backup not completed due to missing Configuration File"
    echo
    exit
fi
#
# Build the names of all the files to backup
#
file_no=1
exec 0< $config_file
#
read file_name
#
while [ $? -eq 0 ]
do 
    if [ -f $file_name -o -d $file_name ]
    then 
        file_list="$file_list $file_name"
        echo $file_list
    else
        echo 
        echo "$file_name,dosen't exist."
        echo "Obviously, I will not include it in this archive."
        echo "It is listed on line $file_no of the config file."
        echo "Continuing to build archive list...."
        echo
    fi
    file_no=[$file_no+1]
    read file_name
done 
#
#################################################################
#
# Backup the files and Compress Archive
#
echo "Starting archiving..."
echo 
#
tar -zcvf $destination $file_list 2> /dev/null
#
echo "Archive completed"
echo "Resulting archive file is: $destination"
echo 
#
exit