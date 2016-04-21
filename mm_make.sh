

TOP_ROOT=$(pwd)
PROJ=$(echo $TARGET_PRODUCT | sed 's/full_//g')
KROOT=$TOP_ROOT/out/target/product/$PROJ/obj/JLINK_KERNEL
OUT_DIR=$TOP_ROOT/out/target/product/$PROJ/

if [ $1 == 'pl' ]; then
make -j16 -C vendor/mediatek/proprietary/bootable/bootloader/preloader -s -f Makefile CROSS_COMPILE=$TOP_ROOT/prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.8/bin/arm-linux-androideabi- PRELOADER_OUT=$TOP_ROOT/out/target/product/$PROJ/obj/PRELOADER_OBJ MTK_PROJECT=$PROJ TOOL_PATH=$TOP_ROOT/device/mediatek/build/build/tools ROOTDIR=$TOP_ROOT
cp $TOP_ROOT/out/target/product/$PROJ/obj/PRELOADER_OBJ/bin/preloader_$PROJ.bin $TOP_ROOT/out/target/product/$PROJ/
fi


if [ $1 == 'lk' ]; then
make -j16 -C vendor/mediatek/proprietary/bootable/bootloader/lk   BOOTLOADER_OUT=$TOP_ROOT/out/target/product/$PROJ/obj/BOOTLOADER_OBJ ROOTDIR=$TOP_ROOT $PROJ
cp $TOP_ROOT/out/target/product/$PROJ/obj/BOOTLOADER_OBJ/build-$PROJ/lk.bin $TOP_ROOT/out/target/product/$PROJ/
cp $TOP_ROOT/out/target/product/$PROJ/obj/BOOTLOADER_OBJ/build-$PROJ/logo.bin $TOP_ROOT/out/target/product/$PROJ/
fi

if [ $1 == 'kk' ]; then
#mkdir $TOP_ROOT/kernel-3.18/OUT_$PROJ
make -j16 -C kernel-3.18 O=$KROOT ARCH=arm64 CROSS_COMPILE=$TOP_ROOT/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/bin/aarch64-linux-android- ROOTDIR=$TOP_ROOT 
echo $OUT_DIR
cp $KROOT/arch/arm64/boot/Image.gz-dtb $OUT_DIR/kernel
make ramdisk-nodeps;
make bootimage-nodeps
fi

if [ $1 == 'kconfig' ]; then
mkdir $KROOT
make -C kernel-3.18 O=$KROOT ARCH=arm64 CROSS_COMPILE=$TOP_ROOT/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/bin/aarch64-linux-android- ROOTDIR=$TOP_ROOT  ${PROJ}_debug_defconfig

fi
