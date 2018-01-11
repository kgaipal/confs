#!/bin/bash

# this script overwrite the following xml tag in config file and keeps launching processes
# need this start condition
# <add key="fileNumber" value="-1"/>

BASE_APP_DIR="C://Users//ksgaipal//Documents//Cosmos"
COSMOS_DATA_DIR_PREFIX="c:\/msys64\/home\/ksgaipal\/Downloads\/CosmosData_201712"

# pull cosomos data into xml files specific
SCOPE_APP="${BASE_APP_DIR}//PullDataFromCosmos//iscopeTool.exe"
SCOPE_APP_CONFIG_FILE=${SCOPE_APP}".config"

# push xml files to SQL specific
SCOPE_SQL_APP="${BASE_APP_DIR}//XportCosmosXMLToDB//ScopeXmlUpdate.exe"
SCOPE_SQL_APP_CONFIG_FILE=${SCOPE_SQL_APP}".config"

# terminal to launch (windows, bash, etc)
TERMINAL_APP="C://msys64//mingw64.exe"

# all 24 hours
MAX_HOUR=23
PAUSE_DURATION_BEFORE_NEW_HOUR_JOB=5m

function create_day_format
{
    echo `printf "%02d" $1`
}

function create_hour_format
{
    echo `printf "%02d" $1`
}

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
    echo "<add key =\"storecosmosfilelocation\" value =\"${COSMOS_DATA_DIR_PREFIX}$1\"\/>"
}

function create_scope_file_read_location_xml_tag
{
    echo "<add key=\"sourcedir\" value=\"${COSMOS_DATA_DIR_PREFIX}$1\"\/>"
}

function print_variables
{
    echo "Script variables:"
    echo -e "* SCOPE_APP:        " $SCOPE_APP
    echo -e "* SCOPE_APP_CONFIG: " $SCOPE_APP_CONFIG_FILE
    echo -e "* TERMINAL:         " $TERMINAL_APP
    echo -e "* COSMOS_DATA_DIR:  " $COSMOS_DATA_DIR_PREFIX
    echo
}

function launch_and_sleep_hour_job
{
    echo -n "starting for $1 hour..."

    eval $TERMINAL_APP $SCOPE_APP
    sleep $PAUSE_DURATION_BEFORE_NEW_HOUR_JOB

    echo " done"
}

function pull_for_a_day
{
    local prev_hour=-1

    for num in `seq 0 1 $MAX_HOUR`
    do
        local hour=`create_hour_format $num`
        local search_text=""
        local replace_text=""

        # replace hour
        search_text=`create_scope_file_number_xml_tag $prev_hour`
        replace_text=`create_scope_file_number_xml_tag $hour`
        sed -i "s/$search_text/$replace_text/g" $SCOPE_APP_CONFIG_FILE

        # launch program for each hour every x seconds
        launch_and_sleep_hour_job $hour

        # update counter
        prev_hour=$hour
    done
}

function pull_for_days_in_range
{
    local prev_day=-1
    local start_day=$1
    local end_day=$2

    for num in `seq $start_day 1 $end_day`
    do
        local day=`create_day_format $num`
        local search_text=""
        local replace_text=""

        # replace date
        search_text=`create_scope_file_date_xml_tag $prev_day`
        replace_text=`create_scope_file_date_xml_tag $day`
        sed -i "s/$search_text/$replace_text/g" $SCOPE_APP_CONFIG_FILE

        # replace downloaded file location
        search_text=`create_scope_file_save_location_xml_tag $prev_day`
        replace_text=`create_scope_file_save_location_xml_tag $day`
        sed -i "s/$search_text/$replace_text/g" $SCOPE_APP_CONFIG_FILE

        echo -n "starting day: ${day}..."
        pull_for_a_day
        echo " done"

        # update counter
        prev_day=$day
    done
}

function push_to_sql
{
    echo "**TODO**"
}

print_variables

# pull data from days inclusive in range [start, end]
pull_for_days_in_range 28 31

# push to sql
push_to_sql
