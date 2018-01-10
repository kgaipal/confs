#!/bin/bash

# this script overwrite the following xml tag in config file
# <add key="fileNumber" value="-1"/>

SCOPE_APP="C://Users//ksgaipal//Documents//Cosmos//PullDataFromCosmos//iscopeTool.exe"
SCOPE_APP_CONFIG_FILE=${SCOPE_APP}".config"
TERMINAL_APP="C://msys64//mingw64.exe"

function create_xml_tag
{
    echo "<add key=\"fileNumber\" value=\"$1\"\/>"
}

function print_variables
{
    echo "following config for this script"
    echo $SCOPE_APP
    echo $SCOPE_APP_CONFIG_FILE
    echo $TERMINAL_APP
}

function launch_cmd_in_sequence
{
    local prev_num=-1
    for num in `seq 0 1 23`
    do
        # prepare search format
        local num2=`printf "%02d" $num`
        local search_text=`create_xml_tag $prev_num`
        local replace_text=`create_xml_tag $num2`

        # replace now
        sed -i "s/$search_text/$replace_text/g" $SCOPE_APP_CONFIG_FILE

        # launch program for each hour every 1 min
        echo "working on hour: $num2"
        eval $TERMINAL_APP $SCOPE_APP
        sleep 1m

        # update counter
        prev_num=$num2
    done
}

print_variables
launch_cmd_in_sequence
