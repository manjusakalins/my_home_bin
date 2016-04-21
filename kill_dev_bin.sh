NAMES=$1
echo $NAMES	
adb shell ps | grep $NAMES | awk '{system("adb shell kill "$2)}'
