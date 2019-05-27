#!/bin/bash
switchbranchName="switchbranch.sh"
deletebranchName="deleteBranch.sh"
createbranchName="createbranch.sh"
initModuleName="initModule.sh"
newCreateBranch="newCreateBranch.sh"
clearSubmodule="clearSubmodule.sh"

##初始化分支的文件
if [ -f "${initModuleName}" ]
then
rm ${initModuleName}
fi 
touch "${initModuleName}" 
echo '#!/bin/bash'>>${initModuleName}
echo 'branchName="master"'>>${initModuleName}
echo 'if [ -n "$1" ];then'>>${initModuleName}
echo 'branchName=$1'>>${initModuleName}
echo 'fi'>>${initModuleName}
echo 'git checkout ${branchName}'>>${initModuleName}
echo 'git pull'>>${initModuleName}
echo 'git submodule update --init'>>${initModuleName}
echo 'git submodule foreach git checkout ${branchName}'>>${initModuleName}
echo 'git submodule foreach git pull'>>${initModuleName}

##切换分支的文件
if [ -f "${switchbranchName}" ]
then
rm ${switchbranchName}
fi 
touch "${switchbranchName}" 
echo '#!/bin/bash'>>${switchbranchName}
echo 'if [ -n "$1" ];then'>>${switchbranchName}
echo './clearSubmodule.sh'>>${switchbranchName}
echo 'git submodule deinit --all'>>${switchbranchName}
echo 'git checkout $1'>>${switchbranchName}
echo 'git pull'>>${switchbranchName}
echo 'git submodule update --init'>>${switchbranchName}
echo 'git submodule foreach git checkout $1'>>${switchbranchName}
echo 'git submodule foreach git pull'>>${switchbranchName}
echo 'else'>>${switchbranchName}
echo 'echo "分支名称不能为空"'>>${switchbranchName}
echo 'fi'>>${switchbranchName}

##删除分支的文件
if [ -f "${deletebranchName}" ]
then
rm ${deletebranchName}
fi 
touch "${deletebranchName}" 
echo '#!/bin/bash'>>${deletebranchName}
echo 'if [ -n "$1" ];then'>>${deletebranchName}
echo 'git branch -d $1'>>${deletebranchName}
echo 'git push origin --delete $1'>>${deletebranchName}
echo 'git submodule foreach git branch -d $1'>>${deletebranchName}
echo 'git submodule foreach git push origin --delete $1'>>${deletebranchName}
echo 'else'>>${deletebranchName}
echo 'echo "分支名称不能为空"'>>${deletebranchName}
echo 'fi'>>${deletebranchName}

##创建分支的文件
if [ -f "${createbranchName}" ]
then
rm ${createbranchName}
fi 
touch "${createbranchName}" 
echo '#!/bin/bash'>>${createbranchName}
echo 'if [ -n "$2" ];then'>>${createbranchName}
echo 'git submodule deinit --all'>>${createbranchName}
echo 'git checkout $2'>>${createbranchName}
echo 'git pull'>>${createbranchName}
echo 'git submodule update --init'>>${createbranchName}
echo 'git submodule foreach git checkout $2'>>${createbranchName}
echo 'git pull origin $2'>>${createbranchName}
echo 'fi'>>${createbranchName}
echo 'if [ -n "$1" ];then'>>${createbranchName}
echo 'git submodule foreach git branch $1'>>${createbranchName}
echo 'git branch $1'>>${createbranchName}
echo 'git submodule foreach git checkout $1'>>${createbranchName}
echo 'git checkout $1'>>${createbranchName}
echo 'git submodule foreach git pull origin $1'>>${createbranchName}
echo 'git pull origin $1'>>${createbranchName}
echo 'git submodule foreach git push origin $1'>>${createbranchName}
echo 'git push origin $1 '>>${createbranchName}
echo 'else'>>${createbranchName}
echo 'echo "创建分支名称不能为空"'>>${createbranchName}
echo 'fi'>>${createbranchName}

##子模块新的创建方式,可以选择
if [ -f "${newCreateBranch}" ]
then
rm ${newCreateBranch}
fi 
touch "${newCreateBranch}" 
echo '#!/bin/bash'>>${newCreateBranch}
echo 'read -p "请输入该分支下的子模块名称(多个用空格分开):"'>>${newCreateBranch}
echo 'branchName=$1'>>${newCreateBranch}
echo 'if [ -n "$branchName" ];then'>>${newCreateBranch}
echo '	echo "分支名称为$branchName"'>>${newCreateBranch}
echo 'else'>>${newCreateBranch}
echo '	echo "分支名称不能为空"'>>${newCreateBranch}
echo '	exit'>>${newCreateBranch}
echo 'fi'>>${newCreateBranch}
echo 'needCount="false"'>>${newCreateBranch}
echo 'if  [ ! -n "$REPLY" ];'>>${newCreateBranch}
echo '	then'>>${newCreateBranch}
echo '	needCount=true'>>${newCreateBranch}
echo '    echo "你选择了全部的子模块"'>>${newCreateBranch}
echo 'fi'>>${newCreateBranch}
echo 'function getdir(){'>>${newCreateBranch}
echo '    for element in `ls $1`'>>${newCreateBranch}
echo '    do  '>>${newCreateBranch}
echo '        dir_or_file=$1"/"$element'>>${newCreateBranch}
echo '        if [ -d $dir_or_file ]; then '>>${newCreateBranch}
echo '            rm -rf $dir_or_file'>>${newCreateBranch}
echo '        fi  '>>${newCreateBranch}
echo '    done'>>${newCreateBranch}
echo '}'>>${newCreateBranch}
echo 'path=$PWD'>>${newCreateBranch}
echo 'unset dirArray'>>${newCreateBranch}
echo 'for element in `ls $path`'>>${newCreateBranch}
echo 'do  '>>${newCreateBranch}
echo '	dir_or_file=$path"/"$element'>>${newCreateBranch}
echo '	if [ -d $dir_or_file ];'>>${newCreateBranch}
echo '	then '>>${newCreateBranch}
echo '		#echo "$needCount"'>>${newCreateBranch}
echo '		dirArray+=(${dir_or_file##*/})'>>${newCreateBranch}
echo '		if [ $needCount == "true" ]; then'>>${newCreateBranch}
echo '				REPLY+=(${dir_or_file##*/})'>>${newCreateBranch}
echo '		fi'>>${newCreateBranch}
echo '	fi  '>>${newCreateBranch}
echo 'done'>>${newCreateBranch}
echo 'for repl in ${REPLY[@]}'>>${newCreateBranch}
echo 'do'>>${newCreateBranch}
echo '	echo $repl'>>${newCreateBranch}
echo 'done'>>${newCreateBranch}
echo 'REPLY+=("pluginDebug")'>>${newCreateBranch}
echo 'REPLY+=("gradle")'>>${newCreateBranch}
echo 'for dirName in ${dirArray[@]}'>>${newCreateBranch}
echo 'do'>>${newCreateBranch}
echo '	if echo "${REPLY[@]}" | grep -iw "$dirName" &>/dev/null; then'>>${newCreateBranch}
echo '			echo "$dirName保留"'>>${newCreateBranch}
echo '		else'>>${newCreateBranch}
echo '			#rm -rf $dirName'>>${newCreateBranch}
echo '			echo "$dirName删除"'>>${newCreateBranch}
echo '			./deleteModule.sh $dirName'>>${newCreateBranch}
echo '	fi'>>${newCreateBranch}
echo 'done'>>${newCreateBranch}
echo 'git stash save'>>${newCreateBranch}
echo 'git stash branch $branchName'>>${newCreateBranch}
echo 'git stash apply'>>${newCreateBranch}
echo 'git submodule foreach git branch $branchName'>>${newCreateBranch}
echo 'git submodule foreach git checkout $branchName'>>${newCreateBranch}
echo 'git submodule foreach git push origin $branchName'>>${newCreateBranch}
echo 'git push origin $branchName'>>${newCreateBranch}
echo 'git stash drop'>>${newCreateBranch}
echo 'git commit --amend -ma'>>${newCreateBranch}



##清除子模块目录，切换分支时需要用到
if [ -f "${clearSubmodule}" ]
then
rm ${clearSubmodule}
fi 
touch "${clearSubmodule}" 
echo '#!/bin/bash'>>${clearSubmodule}
echo 'gradleName="gradle"'>>${clearSubmodule}
echo 'function getdir(){'>>${clearSubmodule}
echo '    for element in `ls $1`'>>${clearSubmodule}
echo '    do  '>>${clearSubmodule}
echo '        dir_or_file=$1"/"$element'>>${clearSubmodule}
echo '        if [ -d $dir_or_file ]'>>${clearSubmodule}
echo '        then '>>${clearSubmodule}
echo '			if [ $element != $gradleName ]'>>${clearSubmodule}
echo '				then'>>${clearSubmodule}
echo '					rm -rf $dir_or_file'>>${clearSubmodule}
echo '			fi'>>${clearSubmodule}
echo '		fi  '>>${clearSubmodule}
echo '    done'>>${clearSubmodule}
echo '}'>>${clearSubmodule}
echo 'path=$PWD'>>${clearSubmodule}
echo 'getdir $path'>>${clearSubmodule}
echo 'getdir "./.git/modules"'>>${clearSubmodule}
