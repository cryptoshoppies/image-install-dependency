#!/usr/bin/env bash

#----------------------------------------------------------
# ARG HELP
#----------------------------------------------------------
function print_help {
    name=$1
    help=$2
    echo "$name $help"
}

#----------------------------------------------------------
# ARG BOOLEAN, example usage: --help, --version
#----------------------------------------------------------
function argb {
    echo argb $@

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
    echo argbr $@

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
    echo argv $@

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
    echo argvr $@

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