#!/bin/bash
set -x

TODIR="" 
# KUBE=""
AZURE=""
                                  # Number of greetings to give. 
usage() {                                 # Function: Print a help message.
  echo "Usage: $0  [ -k KUBE ] [ -a AZURE ] [ -t TODIR ] " 1>&2 
}
exit_abnormal() {                         # Function: Exit with error.
  usage
  exit 1
}
while getopts "k:t:" options; do         # Loop: Get the next option;
                                          # use silent error checking;
                                          # options n and t take arguments.
  case "${options}" in                    # 
    a)                                    # If the option is n,
      AZURE="~/.azure"                      # set $NAME to specified value.
      ;;
    # k)
    #     # outlKUBE=${OPTARG}
    #     KUBE="~/.kube"
    #     ;;
    k|t)                                    # If the option is t,
      TODIR=${OPTARG}  
      echo $TODIR
      KUBE="~/.kube"
      echo "$KUBE"
      if  [[ ! -z "$KUBE" ]] && [ ! -d $TODIR  ]  ; then   # if $TIMES not whole:
        echo " TODIR does not exits creating $TODIR ."
        mkdir -p $TODIR
        echo "Copying contents from $KUBE to $TODIR ."
        cp -R $KUBE/* $TODIR
      elif [ -d $TODIR  ] && [ "$KUBE" ]; then       # If it's zero:
        echo "Copying contents from $KUBE to $TODIR ."
        cp -R $KUBE/* $TODIR
      
      fi
      ;;
    :)                                    # If expected argument omitted:
      echo "Error: -${OPTARG} requires an argument."
      exit_abnormal                       # Exit abnormally.
      ;;
    *)                                    # If unknown (any other) option:
      exit_abnormal                       # Exit abnormally.
      ;;
  esac
  shift
done

# restore (){

# }
# if [ "$KUBE" = "" ]; then                 # If $NAME is an empty string,
#   STRING="Hi!"                            # our greeting is just "Hi!"
# else                                      # Otherwise,
#   STRING="Hi, $KUBE!"                     # it is "Hi, (name)!"
# fi
# COUNT=1                                   # A counter.
# while [ $COUNT -le $TODIR ]; do           # While counter is less than
#                                           # or equal to $TODIR,
#   echo $STRING                            # print a greeting,
#   let COUNT+=1                            # then increment the counter.
# done
exit 0                   