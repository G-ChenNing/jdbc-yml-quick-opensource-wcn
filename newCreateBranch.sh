#!/bin/bash
read -p "请输入该分支下的子模块名称(多个用空格分开):"
branchName=$1
if [ -n "$branchName" ];then
	echo "分支名称为$branchName"
else
	echo "分支名称不能为空"
	exit
fi
needCount="false"
if  [ ! -n "$REPLY" ];
	then
	needCount=true
    echo "你选择了全部的子模块"
fi
function getdir(){
    for element in `ls $1`
    do  
        dir_or_file=$1"/"$element
        if [ -d $dir_or_file ]; then 
            rm -rf $dir_or_file
        fi  
    done
}
path=$PWD
unset dirArray
for element in `ls $path`
do  
	dir_or_file=$path"/"$element
	if [ -d $dir_or_file ];
	then 
		#echo "$needCount"
		dirArray+=(${dir_or_file##*/})
		if [ $needCount == "true" ]; then
				REPLY+=(${dir_or_file##*/})
		fi
	fi  
done
for repl in ${REPLY[@]}
do
	echo $repl
done
REPLY+=("pluginDebug")
REPLY+=("gradle")
for dirName in ${dirArray[@]}
do
	if echo "${REPLY[@]}" | grep -iw "$dirName" &>/dev/null; then
			echo "$dirName保留"
		else
			#rm -rf $dirName
			echo "$dirName删除"
			./deleteModule.sh $dirName
	fi
done
git stash save
git stash branch $branchName
git stash apply
git submodule foreach git branch $branchName
git submodule foreach git checkout $branchName
git submodule foreach git push origin $branchName
git push origin $branchName
git stash drop
git commit --amend -ma
