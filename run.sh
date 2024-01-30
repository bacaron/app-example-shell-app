#!/bin/bash

set -x # log messages to the .log log
set -e # error messages to the .err log

# define my inputs
# t1="/home/bacaron/Desktop/shell-app-example/inputs/t1.nii.gz" # datatype input
# number_to_add=1 # configurable parameter

t1=`jq -r '.t1' config.json` # path that can be made variable and is filled in by brainlife itself
echo ${t1}
number_to_add=`jq -r '.number_to_add' config.json` # allows to be variable input specified by user
echo ${number_to_add}

# make the output directory
[ ! -d ./output ] && mkdir ./output

# add our "number_to_add" parameter to each voxel in the t1 input data
[ ! -f ./output/t1.nii.gz ] && fslmaths ${t1} -add ${number_to_add} ./output/t1.nii.gz

# one final check to make sure the output was generated
if [ -f ./output/t1.nii.gz ]; then
    echo "app completed succesfully"
    exit 0
fi
echo "app failed. check files and logs"
exit 1