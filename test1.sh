#!/bin/bash 

function usage() {
  echo "Usage: $0 [ -k | kubdir ] [ -a | azuredir ] [ -f KUBEBAKDIR] [ -g AZUREBAKDIR ][-h]  "
}

while getopts "kasprhf:g:" opt; do
    case "$opt" in
    k) KUBE="$HOME/.kube";;
    a) AZURE="$HOME/.azure";;
    s) AZURESP="$HOME/azurespbak";;
    p) KUBESP="$HOME/kubespbak" ;;
    r) RESTORE="TRUE";;=    h) usage && exit 0;;
    f) KUBEBAKDIR="$OPTARG";;
    g) AZUREBAKDIR="$OPTARG";;

    esac
    done
    shift $(( OPTIND - 1 ))

kube_backup(){
# name=${1:?$( usage )}
echo "Backing up $KUBE directory to $KUBEBAKDIR"
if [[ -n  "$KUBE" ]] && [ ! -z $KUBEBAKDIR ]; then
  echo " $KUBE , $KUBEBAKDIR "
  if   [ ! -d $KUBEBAKDIR  ]  ; then   :
        echo " KUBEBAKDIR does not exits creating $KUBEBAKDIR ."
        mkdir -p $KUBEBAKDIR
        echo "Copying contents from $KUBE to $KUBEBAKDIR ."
        cp -R $KUBE/* $KUBEBAKDIR
      elif [ -d $KUBEBAKDIR  ] && [ "$KUBE" ]; then       # If it's zero:
        echo "Copying contents from $KUBE to $KUBEBAKDIR ."
        echo "$KUBE"
        cd "$KUBE"
        cp -R $KUBE/* $KUBEBAKDIR
      
  fi
fi
}

azure_backup() {
echo "Backing up $AZURE directory to $AZUREBAKDIR"
if [[ -n  "$AZURE" ]] && [ ! -z $AZUREBAKDIR ]; then
  echo " $AZURE , $AZUREBAKDIR "
  if   [ ! -d $AZUREBAKDIR  ]  ; then   :
        echo " AZUREBAKDIR does not exits creating $AZUREBAKDIR ."
        mkdir -p $AZUREBAKDIR
        echo "Copying contents from $AZURE to $AZUREBAKDIR ."
        cp -R $AZURE/* $AZUREBAKDIR
      elif [ -d $AZUREBAKDIR  ] && [ "$AZURE" ]; then       # If it's zero:
        echo "Copying contents from $AZURE to $AZUREBAKDIR ."
        echo "$AZURE"
        cd "$AZURE"
        cp -R $AZURE/* $AZUREBAKDIR
      
  fi
fi
}


azure_restore() {
    echo "restoring azure config. "

      if [ $RESTORE ] && [ -d $AZUREBAKDIR  ] && [ "$AZURE" ]; then       
        echo "Restoring from $AZUREBAK to $AZURE ."
        cp -R $AZUREBAK/* $AZURE
      elif [ $RESTORE ] && [ -d $AZURESP  ] && [ "$AZURE" ]; then       
        echo "Restoring from $AZURESPBAK to $AZURE ."
        cp -R $AZURESPBAK/* $AZURE

      fi
}

kube_restore() {
    echo "restoring k8's config. "

      if [ -n $RESTORE ] && [ -d $KUBEBAKDIR  ] && [ "$KUBE" ]; then       
        echo "Restoring from $KUBEBAK to $KUBE."
        cp -R $KUBEBAKDIR/* $KUBE
      elif [ $RESTORE ] && [ -d $KUBESP  ] && [  "$KUBE" ]; then       
        echo "Restoring from $KUBESPBAK to $KUBE."
        cp -R $KUBESPBAK/* $KUBE

      fi
}
main(){
    kube_backup
    azure_backup
    kube_restore
    azure_restore


    echo "Complete!"
    exit 0
}
main