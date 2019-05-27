#!/bin/bash
if [ -n "$1" ];then
./clearSubmodule.sh
git submodule deinit --all
git checkout $1
git pull
git submodule update --init
git submodule foreach git checkout $1
git submodule foreach git pull
else
echo "分支名称不能为空"
fi
