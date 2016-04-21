DIRCOMP=$(pwd)
cd $DIRCOMP;
echo $DIRCOMP;
PROJECT=$(cat makeMtk.ini | grep project | awk '{print $3}')
adb shell reboot bootloader; fastboot flash boot ./out/target/product/$PROJECT/boot.img;fastboot reboot;
