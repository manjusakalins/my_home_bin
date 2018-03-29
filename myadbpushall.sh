echo $1
echo $0
echo "usage: xx.sh dirpath"
ls | awk -v var="$1" '{system("adb push \""$0"\" "var)}'

