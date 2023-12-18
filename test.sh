#!/bin/bash

#!/bin/bash

while getopts ":b:rgc:" OPTION; do
    case $OPTION in
    b)
        COLOR=BLUE
        shift
        ;;
    r)
        COLOR=RED
        shift
        ;;
    g)
        COLOR=GREEN
        ;;
    c)
        COLOR=$OPTARG
        [[ ! $COLOR =~ BLUE|RED|GREEN ]] && {
            echo "Incorrect options provided"
            exit 1
        }
        ;;
    *)
        echo "Incorrect options provided"
        exit 1
        ;;
    esac
done

echo "Color is $COLOR"


exit 0;