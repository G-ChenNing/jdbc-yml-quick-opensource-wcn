#!/bin/bash
if [ -n "$1" ];then
git branch -d $1
git push origin --delete $1
git submodule foreach git branch -d $1
git submodule foreach git push origin --delete $1
else
echo "分支名称不能为空"
fi
