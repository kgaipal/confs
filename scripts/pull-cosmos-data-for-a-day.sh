#!/bin/bash

# <add key="fileNumber" value="-1"/>

CONFIG_FILE="c://msys64//home//ksgaipal//Documents//Cosmos//PullDataFromCosmos//iscopeTool.exe.config"
PROGRAM_EXE="C://Users//ksgaipal//Documents//Cosmos//PullDataFromCosmos//iscopeTool.exe"
# CMD_EXE="START cmd.exe /C "
CMD_EXE="C://msys64//mingw64.exe"

function create_xml_tag
{
    echo "<add key=\"fileNumber\" value=\"$1\"\/>"
}

function launch_cmd_in_sequence
{
    local prev_num=-1
    for num in `seq 0 1 23`
    do
        # prepare search format
        local num2=`printf "%02d" $num`
        echo "$prev_num -> $num2"
        local search_text=`create_xml_tag $prev_num`
        local replace_text=`create_xml_tag $num2`

        # replace now
        sed -i "s/$search_text/$replace_text/g" $CONFIG_FILE

        # launch program
        eval $CMD_EXE $PROGRAM_EXE
        sleep 30s

        # update counter
        prev_num=$num2

    done
}

launch_cmd_in_sequence
