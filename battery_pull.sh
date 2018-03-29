echo "quick pull for kmsg: usage:"
echo "\t\t batpull file_name:   adb pull /sdcard/DCIM/file_name"

echo "adb pull /sdcard/DCIM/" + $1
adb pull /sdcard/DCIM/$1
