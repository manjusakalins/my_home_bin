#!/bin/bash
infile='/mnt/data/all_codes/mtk_codes/exocet_jb_6577/out/target/product/te711/system/xbin/sqlite3'
adb remount;
adb push $infile /system/bin/;
echo 'sqlite3 /data/data/com.android.providers.settings/databases/settings.db "insert into system (name,value) values('screen_off_timeout',1800);"' > aa.sh;
adb push aa.sh /system/bin/;
adb shell chmod 777 system/bin/aa.sh;
adb shell sh /system/bin/aa.sh;
adb shell rm /system/bin/aa.sh;
#{
#	echo bc
#	echo 'sqlite3 /data/data/com.android.providers.settings/databases/settings.db "insert into system (name,value) values('screen_off_timeout',180000);"'
#	echo "exit"
#} | adb shell 






