#!/bin/bash

set -e
GROUP="$1"
GUID="$2"
URL="$3"
THREADS="$4"
REGION="$5"

output=`aws cloudformation describe-stacks --stack-name $GUID --region $REGION --query Stacks[].Outputs[].OutputValue | sed -r 's/"+//g'`
grid=`echo $output | awk {'print $2'}`

######################
##   Running test  ##
######################
python3.7 -m pip install -r requirements.txt
#Running tests with apropriate marker
python3.7 -m pytest -m $GROUP --url $URL --environment remote --hub $grid -v -n $THREADS --reruns 1 --html=./results/report.html