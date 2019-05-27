#!/bin/bash
if [ -n "$2" ];then
git submodule deinit --all
git checkout $2
git pull
git submodule update --init
git submodule foreach git checkout $2
git pull origin $2
fi
if [ -n "$1" ];then
git submodule foreach git branch $1
git branch $1
git submodule foreach git checkout $1
git checkout $1
git submodule foreach git pull origin $1
git pull origin $1
git submodule foreach git push origin $1
git push origin $1 
else
echo "创建分支名称不能为空"
fi
