#!/bin/bash
gradleName="gradle"
function getdir(){
    for element in `ls $1`
    do  
        dir_or_file=$1"/"$element
        if [ -d $dir_or_file ]
        then 
			if [ $element != $gradleName ]
				then
					rm -rf $dir_or_file
			fi
		fi  
    done
}
path=$PWD
getdir $path
getdir "./.git/modules"
