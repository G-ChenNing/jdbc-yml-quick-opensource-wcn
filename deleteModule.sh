#!/bin/bash
function getLineNum(){
	grep -n "submodule \""$1"\"" ./.gitmodules | cut -d ":" -f 1
}
function getLineNumForGit(){
	grep -n "submodule \""$1"\"" ./.git/config | cut -d ":" -f 1
}
if [ -n "$1" ];then
	git rm -r --cached $1
	rm -rf $1
	rm -rf .git/modules/$1
	#删除文件
	line=$(getLineNum $1)
	gitLine=$(getLineNumForGit $1)
	echo "line is "$line""
	if [ -n "${line}" ];then
		#连续删除三次
		sed -i "${line}d"  ./.gitmodules
		sed -i "${line}d"  ./.gitmodules
		sed -i "${line}d"  ./.gitmodules
	else
		echo "./.gitmodules不存在文本内容"
	fi
	if [ -n "${gitLine}" ];then
		#连续删除三次
		sed -i "${gitLine}d"  ./.git/config
		sed -i "${gitLine}d"  ./.git/config
		sed -i "${gitLine}d"  ./.git/config
	else
		echo "./.git/config不存在文本内容"
	fi

else
	echo "请输入子模块名称"
fi