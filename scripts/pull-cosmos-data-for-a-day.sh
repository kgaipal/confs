#!/bin/bash

# this script overwrite the following xml tag in config file
# <add key="fileNumber" value="-1"/>
BASE_DIR="C://Users//ksgaipal//Documents"
SCOPE_APP="${BASE_DIR}/Cosmos//PullDataFromCosmos//iscopeTool.exe"
SCOPE_APP_CONFIG_FILE=${SCOPE_APP}".config"
TERMINAL_APP="C://msys64//mingw64.exe"
MAX_HOUR=23

function create_scope_file_number_xml_tag
{
    echo "<add key=\"fileNumber\" value=\"$1\"\/>"
}

function create_scope_file_date_xml_tag
{
    echo "<add key=\"date\" value=\"$1\"\/>"
}

function create_scope_file_save_location_xml_tag
{
    echo "<add key =\"storecosmosfilelocation\" value =\"$1\"\/>"
}

function print_variables
{
    echo "Script variables:"
    echo -e "* SCOPE_APP: " $SCOPE_APP
    echo -e "* SCOPE_APP_CONFIG: " $SCOPE_APP_CONFIG_FILE
    echo -e "* TERMINAL: " $TERMINAL_APP
    echo
}

function pull_for_a_day
{
    local prev_num=-1
    for num in `seq 0 1 $MAX_HOUR`
    do
        # prepare search format
        local num2=`printf "%02d" $num`
        local search_text=`create_scope_file_number_xml_tag $prev_num`
        local replace_text=`create_scope_file_number_xml_tag $num2`

        # replace now
        sed -i "s/$search_text/$replace_text/g" $SCOPE_APP_CONFIG_FILE

        # launch program for each hour every 1 min
        echo "starting hour: $num2"
        eval $TERMINAL_APP $SCOPE_APP
        sleep 5m

        # update counter
        prev_num=$num2
    done

    echo "done."
}

print_variables
pull_for_a_day