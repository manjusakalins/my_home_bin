#!/bin/bash

DIRS=$(pwd)
echo $DIRS
#sed -i -e 's/[ \t]*$//g'
for filss in $(ls $DIRS)
do
	echo $filss

	sed -i -e 's/[ \t]*$//g' $filss;

	{
		echo "vG"
		echo "99<"
		echo "gg=G"
		echo ":wq"
	}|vi $filss;

done
