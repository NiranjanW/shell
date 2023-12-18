#!/bin/bash
set -x

help()
{
    echo "Usage: serviceprincipal [ -f | --fromdir ]
               [ -t | --todir ]
               [ -k | --kube ]
               [ -a | --azure ]
               [ -h | --help  ]"
    exit 2
}

SHORT=f:,t:,k:,a:,h
LONG=fromdir:,todir:,help
# OPTS=$(getopts -a  serviceprincipal --options $SHORT --longoptions $LONG -- "$@")
OPTS=$(getopt  -a --options $SHORT  -- "$@")

VALID_ARGUMENTS=$#

echo $VALID_ARGUMENTS

if [ "$VALID_ARGUMENTS" -eq 0 ]; then
  help
fi

eval set -- "$OPTS"
echo "$OPTS"
# while getopts $SHORT OPTION; do
# echo $OPTION
while :
do
  case "$1" in
    -f)
        fromdir="$2"
        echo $fromdir
        shift 2
      ;;
   -t)
        todir="$3"
        echo $todir
    #   shift 1
      ;;
    -h | --help)
      help
      ;;
    --)
      shift;
      break
      ;;
    *)
      echo "Unexpected option: $1"
      help
      ;;
  esac
done

  if  [ ! -d $todir ] ; then
  echo "making dir $fromdir , $todir"
      mkdir -p $todir  
  else  
    if [ "$fromdir" ] && [ "$todir" ]
    then
        cp -r $fromdir/* $todir  
    fi
  fi






