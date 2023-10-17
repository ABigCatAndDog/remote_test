#!/bin/bash
#
# Set specified signal traps; then run script in background
#
############################## Check Signals to Trap ################################
#
while getopts S: opt
do 
    case "$opt" in
    S)  #Found the -S option
        signalList=""
        #
        for arg in $OPTARG
        do 
            case $arg in 
            1)  #SIGHUP signal is handled
                signalList=$signalList" SIGHUP"
                ;;
            2)  #SIGINT signal is handled
                signalList=$signalList" SIGINT"
                ;;
            20) #SIGTSTP signal is handled
                signalList=$signalList" SIGTSTP"
                ;;
            *)  #Unknown or unhandled signal
                echo "Only signals 1 2 and/or 20 are allowed"
                echo "Exiting script..."
                exit
                ;;
            esac
        done 
        ;;
    *)  echo 'Usage: -S "Signal(s)" script-to-run-name'
        echo 'Exiting script...'
        exit
        ;;
    esac
done
#
################################## Check Script to Run ####################################
#
shift $[$OPTIND-1]
#
if [ -z $@ ]
then 
    echo 
    echo "Error: Script name not provide."
    echo 'Usage: -S "Signal(s)" script-to-run-name'
    echo "Exiting script..."
    exit
elif [ -O $@ ] && [ -x $@ ]
then
    scriptToRun=$@
    scriptOutPut="$@.out"
else
    echo 
    echo "Error: $@ is either not owned by you or not executable."
    echo "Exiting..."
    exit
fi
#
#################################### Trap and Run #############################
#
echo 
echo "Running the $scriptToRun script in background"
echo "while trapping signal(s): $signalList"
echo "Output of script sent to: $scriptOutPut"
echo
trap "" $signalList
#
source $scriptToRun > $scriptOutPut &
#
trap -- $signalList
#
################################## Exit script ###############################
#
exit
