#!/bin/bash

WORKING_DIR="."

## ..:: usage function ::..
## ----------------------------------------------------------------------------

usage(){
	echo "
  Usage: $0 [<pip|nopip>]
 
  pip:                   allocates Public IP(s)
  nopip:                 does not allocate Public IP(s)
"
	exit 1
}

## ..:: main ::..
## ----------------------------------------------------------------------------

IS_MODULE_NAME_SET=0

[[ $# -eq 0 ]] && usage

echo "Setting working dir to $WORKING_DIR"
cd $WORKING_DIR

case "$1" in
	"pip" )
	__MODULE_NAME__="f5-bigip-ve"
	IS_MODULE_NAME_SET=1
	;;
	"nopip" )
	__MODULE_NAME__="f5-bigip-ve-no-pip"
	IS_MODULE_NAME_SET=1
	;;
    *)
	usage
esac

cd $WORKING_DIR
if (( $IS_MODULE_NAME_SET ))
then
	echo "Replacing __MODULE_NAME__ with $__MODULE_NAME__"
	cp main.template main.tf
    sed -i "s/__MODULE_NAME__/$__MODULE_NAME__/g" main.tf
fi

terraform init
terraform plan

read -p "Do you want to actaullt appy this? (Yy for yes)" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    terraform apply
else
    echo "Got it, you just wanted to test it, fair enough! Ciao"
    exit 0
fi

