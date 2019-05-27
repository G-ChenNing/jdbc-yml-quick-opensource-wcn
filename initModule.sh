#!/bin/bash
branchName="master"
if [ -n "$1" ];then
branchName=$1
fi
git checkout ${branchName}
git pull
git submodule update --init
git submodule foreach git checkout ${branchName}
git submodule foreach git pull
