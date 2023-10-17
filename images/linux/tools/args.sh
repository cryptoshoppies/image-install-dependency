#!/usr/bin/env bash

IS_OK=true

#----------------------------------------------------------
# ECHO COLORS
#----------------------------------------------------------
function echo_red {
    local RED='\033[0;31m'
    local NC='\033[0m' # No Color
    echo -e "${RED}${1}${NC}"
}

function echo_green {
    local RED='\033[0;32m'
    local NC='\033[0m' # No Color
    echo -e "${RED}${1}${NC}"
}

function echo_yellow {
    local RED='\033[1;33m'
    local NC='\033[0m' # No Color
    echo -e "${RED}${1}${NC}"
}

function echo_cyan {
    local RED='\033[0;36m'
    local NC='\033[0m' # No Color
    echo -e "${RED}${1}${NC}"
}

#----------------------------------------------------------
# STATUS
#----------------------------------------------------------

function echo_status {
    msg="=========================================================="
    
    $IS_OK && echo_green $msg || echo_red $msg
    $IS_OK && echo_green "OK" || echo_red "FAILED"
    $IS_OK && echo_green $msg || echo_red $msg
}

function exit_status {
    $IS_OK && exit 0 || exit 1
}

function ok {
    echo_green "OK"
}

function fail {
    IS_OK=false
    echo_red "FAILED"
}

#----------------------------------------------------------
# RUN
#----------------------------------------------------------
function install {
    echo "=========================================================="
    echo $1
    echo "----------------------------------------------------------"
    source_file=$1
    shift
    source $source_file
    if [[ $HELP ]]; then
        help
    else
        execute $@ && ok || fail
    fi
    echo "=========================================================="
    echo ""
}

#----------------------------------------------------------
# ARG HELP
#----------------------------------------------------------
function print_help {
    name=$1
    help=$2
    echo_green "=========================================================="
    echo_yellow $name
    echo_green "----------------------------------------------------------"
    echo_cyan "$name $help"
    echo_green "=========================================================="
    echo ""
}

#----------------------------------------------------------
# ARG BOOLEAN, example usage: --help, --version
#----------------------------------------------------------
function argb {
    [[ $VERBOSE ]] && echo argb $@

    name=$1
    variable=$2
    help=$3

    shift
    shift
    shift

    while [[ "$#" -gt 0 ]]; do
        case $1 in
        $name)
            export declare $variable=true
            ;;

        --help)
            print_help $name $help
            ;;
        esac
        shift
    done
}

#----------------------------------------------------------
# ARG BOOLEAN, check required, example usage: --help, --version
#----------------------------------------------------------
function argbr {
    [[ $VERBOSE ]] && echo argbr $@

    name=$1
    variable=$2
    help=$3

    shift
    shift
    shift

    while [[ "$#" -gt 0 ]]; do
        case $1 in
        $name)
            export declare $variable=true
            ;;

        --help)
            print_help $name $help
            ;;
        esac
        shift
    done

    [[ -z $variable ]] && echo "$name is required" && exit 1
}

#----------------------------------------------------------
# ARG VALUE, example usage: --version 1.0.0
#----------------------------------------------------------
function argv {
    [[ $VERBOSE ]] && echo argv $@

    name=$1
    variable=$2
    help=$3

    shift
    shift
    shift

    while [[ "$#" -gt 0 ]]; do
        case $1 in
        $name)
            export declare $variable="$2"
            shift
            ;;

        --help)
            print_help $name $help
            ;;
        esac
        shift
    done
}

#----------------------------------------------------------
# ARG VALUE, check as required, example usage: --version 1.0.0
#----------------------------------------------------------
function argvr {
    [[ $VERBOSE ]] && echo argvr $@

    name=$1
    variable=$2
    help=$3

    shift
    shift
    shift

    while [[ "$#" -gt 0 ]]; do
        case $1 in
        $name)
            export declare $variable="$2"
            shift
            ;;

        --help)
            print_help $name $help
            ;;
        esac
        shift
    done

    [[ -z $variable ]] && echo "$name is required with value" && exit 1
}

#----------------------------------------------------------
function exit_if_help {
    [[ $HELP ]] && exit 0
}
#----------------------------------------------------------

argb --help HELP "--help" $@
