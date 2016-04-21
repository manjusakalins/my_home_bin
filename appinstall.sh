echo $(pwd)
ls $(pwd) | awk '{system("adb install \""$0"\"")}'

