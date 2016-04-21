
BUILD_K_CONFIG=0;
if [ ! $1 ]; then
	echo "build kernel"	
else
	echo "build config"
	BUILD_K_CONFIG=1;
fi

ARCH_64=$(echo $ANDROID_TOOLCHAIN | grep 64)
echo $ARCH


PROJ=$(echo $TARGET_PRODUCT | sed 's/full_//g');
CURDIRLL=$(pwd)

## ccache config ##
#mkdir /media/2Tdata/for_ccache_dir/$PROJ
#export USE_CCACHE=1
#export CCACHE_DIR=/media/2Tdata/for_ccache_dir/$PROJ
#export CCACHE_LOGFILE=/media/2Tdata/for_ccache_dir/$PROJ/ccache.logss
#RRRE=$(ccache -M 1G​)
#RRRE=$(ccache -s)
#echo $RRRE

if [ ! $ARCH_64 ]; then
	#start arm build
	echo "BUILD ARM"
	if [ $BUILD_K_CONFIG == 1 ]; then
		mkdir kernel-3.10/OUT_$PROJ;
		cd kernel-3.10;
		make O=OUT_${PROJ} ${PROJ}_debug_defconfig ARCH=arm;
		cd -
	else
		echo $CCACHE_DIR
		echo "#############################################"
		make -j16 -C kernel-3.10 O=$CURDIRLL/kernel-3.10/OUT_${PROJ}/ ARCH=arm CROSS_COMPILE="$ARM_EABI_TOOLCHAIN/arm-eabi-" ROOTDIR=$CURDIRLL;
		cp $CURDIRLL/kernel-3.10/OUT_${PROJ}/arch/arm/boot/zImage-dtb  $CURDIRLL/out/target/product/$PROJ/kernel;
		make ramdisk-nodeps;
		make bootimage-nodeps
	fi

else
	echo "BUILD ARM64"
    if [ $1 == "user" ]; then
        echo "build user config"
		mkdir kernel-3.10/OUT_$PROJ;
		cd kernel-3.10;
		make O=OUT_${PROJ} ${PROJ}_defconfig ARCH=arm64;
		cd -
	elif [ $BUILD_K_CONFIG == 1 ]; then
		mkdir kernel-3.10/OUT_$PROJ;
		cd kernel-3.10;
		make O=OUT_${PROJ} ${PROJ}_debug_defconfig ARCH=arm64;
		cd -
	else
		echo $CCACHE_DIR
		echo "#############################################"
		make -j16 -C kernel-3.10 O=$CURDIRLL/kernel-3.10/OUT_${PROJ}/ ARCH=arm64 CROSS_COMPILE="ccache $ANDROID_TOOLCHAIN/aarch64-linux-android-" ROOTDIR=$CURDIRLL;
		cp $CURDIRLL/kernel-3.10/OUT_${PROJ}/arch/arm64/boot/Image.gz-dtb $CURDIRLL/out/target/product/$PROJ/kernel;
		make ramdisk-nodeps;
		make bootimage-nodeps
	fi
	
fi
