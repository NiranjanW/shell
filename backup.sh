#!/usr/bin/env bash

KUBEDIR=~/.kube
AZUREDIR=~/.azure
KUBESPDIR=~/.kubesp
AZURESPDIR=~/.azuresp
KUBEBAKDIR=~/.kubebak 
AZUREBAKDIR=~/.azurebak

backup_kube() {
    if [ -d  $KUBEDIR  ]; then
        echo "directory \"$KUBEDIR\" exists"
        if [ -d $KUBESPDIR ] && [ -d $KUBEBAKDIR]; then 
            echo "directory \"$KUBESPDIR,  $KUBEBAKDIR\" exists"
            echo "backing up kubesp to kubebak"
            cp -r $KUBESPDIR/* $KUBESPBAK  
            echo "backing up kube to kubesp"
            cp -r $KUBEDIR/* $KUBESPDIR
            if [ -n !"$(find $KUBESPDIR -prune -empty)" ] ; then 
                echo "not empty"
            else
                echo "$KUBESPDIR is empty please check"
                exit 2
            fi 
        else 
            echo "creating a $kubesp directory"
            mkdir $KUBESPDIR
            cp -r $KUBEDIR/* $KUBESPDIR 
            if [ -n !"$(find $KUBESPDIR -prune -empty)" ] ; then 
                echo "not empty"
            fi
        fi
    fi
}
restore_kube () {
    echo "Restoring kub config from backup"
    if [ -n !"$(find $KUBEBAKDIR -prune -empty)" ] ; then 
            echo "kubeconfig bakup is not empty"
            cp -r $KUBEBAKDIR/* $KUBEDIR
         else
            echo "$KUBEBAKDIR is empty cannot restore please check"
            exit 2
         fi 

}

restore_azure () {
    echo "Restoring azure config from backup"
    if [ -n !"$(find $AZUREBAKDIR -prune -empty)" ] ; then 
            echo "azureconfig backup is not empty"
            cp -r $AZUREBAKDIR/* $AZUREDIR
         else
            echo "$AZUREBAKDIR is empty cannot restore please check"
            exit 2
         fi 

}

backup_azure() {

    if [ -d  $AZUREDIR  ]; then
        echo "directory \"$AZUREDIR\" exists"
        if [ -d $AZURESPDIR ]; then 
            echo "directory \"$AZURESPDIR\" exists"  
            echo "backing up kube to kubesp"
            cp -r $AZUREDIR/* $AZURESPDIR
            if [ -n !"$(find $AZURESPDIR -prune -empty)" ] ; then 
                echo "not empty"
            else
                echo "$AZURESPDIR is empty please check"
                exit 2
            fi 
        else 
            echo "creating a $kubesp directory"
            mkdir $AZURESPDIR
            cp -r $AZUREDIR/* $AZURESPDIR 
            if [ -n !"$(find $AZURESPDIR -prune -empty)" ] ; then 
                echo "not empty"
            fi
        fi
    fi
}

function main () {
    backup_kube
    backup_azure
    restore_kube
    restore_azure
    
}

main
