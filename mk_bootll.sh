#!/bin/bash
DIRCOMP=$(pwd)
cd $DIRCOMP;
echo $DIRCOMP;
#PROJECT=$(cat makeMtk.ini | grep project | awk '{print $3}')
PROJECT=$TARGET_PRODUCT
#make -j8  kernel
#echo mkbootimg --kernel kernel/out/kernel_$PROJECT.bin --ramdisk ./out/target/product/$PROJECT/ramdisk.img -o ./out/target/product/$PROJECT/boot.img
echo  mkbootimg --kernel $OUT/kernel --ramdisk $OUT/ramdisk.img -o $OUT/boot.img
 mkbootimg --kernel $OUT/kernel --ramdisk $OUT/ramdisk.img -o $OUT/boot.img
