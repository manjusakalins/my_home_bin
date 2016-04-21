ls | awk '{system("adb push \""$0"\" /sdcard/")}'
