#!/usr/bin/env bash

function install_sysconfig() {
    FILE=/etc/sysctl.conf

    # ---------------------------------------------------------
    # vm.overcommit_memory
    # ---------------------------------------------------------
    SEARCH=vm.overcommit_memory
    LINE=vm.overcommit_memory=1

    # Check if the line exists in the file
    grep -qF "$SEARCH" "$FILE"

    # If the line was not found, append it
    if [ $? -ne 0 ]; then
        echo "Adding $LINE to $FILE"
        echo "$LINE" >>"$FILE"
    else
        echo "$SEARCH is already present in $FILE."
    fi
    # ---------------------------------------------------------

    # ---------------------------------------------------------
    # vm.max_map_count
    # ---------------------------------------------------------
    SEARCH=vm.max_map_count
    LINE=vm.max_map_count=262144

    # Check if the line exists in the file
    grep -qF "$SEARCH" "$FILE"

    # If the line was not found, append it
    if [ $? -ne 0 ]; then
        echo "Adding $LINE to $FILE"
        echo "$LINE" >>"$FILE"
    else
        echo "$SEARCH is already present in $FILE."
    fi
    # ---------------------------------------------------------
}

[[ ! $HELP ]] && install_sysconfig $@ || echo "configure vm.max_map_count=262144 and vm.overcommit_memory=1"
