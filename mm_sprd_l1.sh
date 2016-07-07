

TOP_ROOT=$(pwd)
#PROJ=$(echo $TARGET_PRODUCT | sed 's/full_//g')
#KROOT=$TOP_ROOT/out/target/product/$PROJ/obj/JLINK_KERNEL
OUT_DIR=$ANDROID_PRODUCT_OUT
KROOT=$OUT_DIR/obj/JLINK_KERNEL


for i in $(echo $OUT_DIR| tr "/" "\n")
do
	PROJ=$i
done
echo $OUT_DIR
echo $PROJ

if [ $1 == 'chipram' ]; then
	make -C chipram CROSS_COMPILE=arm-eabi- O=../out/target/product/$PROJ/obj/chipram distclean
	make -C chipram CROSS_COMPILE=arm-eabi- O=../out/target/product/$PROJ/obj/chipram ${PROJ}_config
	make -C chipram CROSS_COMPILE=arm-eabi- AP_VERSION="" O=../out/target/product/$PROJ/obj/chipram
	cp ${OUT_DIR}/obj/chipram/nand_fdl/fdl1.bin ${OUT_DIR}
	cp ${OUT_DIR}/obj/chipram/nand_spl/u-boot-spl-16k.bin ${OUT_DIR}
fi

if [ $1 == 'bootloader' ]; then
	if [[ $PROJ == *"scx20"* ]]; then
		echo "ori project xxxxx"
		KCF_PROJ=${PROJ/scx20_/ }
		echo $KCF_PROJ
	else
		KCF_PROJ=${PROJ}
	fi
	make -C u-boot64 CROSS_COMPILE=arm-eabi- O=../out/target/product/$PROJ/obj/u-boot64 distclean
	make -C u-boot64 CROSS_COMPILE=arm-eabi- DEBUGF=true CONFIG_BOARD=false O=../out/target/product/$PROJ/obj/u-boot64 ${KCF_PROJ}_config
	make -C u-boot64 CROSS_COMPILE=arm-eabi- DEBUGF=true CONFIG_BOARD=false O=../out/target/product/$PROJ/obj/u-boot64
	cp ${OUT_DIR}/obj/u-boot64/u-boot.bin ${OUT_DIR}
	cp ${OUT_DIR}/obj/u-boot64/u-boot.bin ${OUT_DIR}/fdl2.bin
	cp ${OUT_DIR}/obj/u-boot64/fdl2.bin ${OUT_DIR}
	fi

if [ $1 == 'bootimage' ]; then

	echo $KROOT;
	JLINK_KERNEL_OUT_TOP=out/target/product/$PROJ/obj/JLINK_KERNEL
	JLINK_KERNEL_OUT=../out/target/product/$PROJ/obj/JLINK_KERNEL
	JLINK_DTC_OUT=out/target/product/$PROJ/obj/JLINK_KERNEL/scripts/dtc/
	JLINK_DTC_OUT2=out/target/product/$PROJ/obj/JLINK_KERNEL/arch/arm/boot/dts/
	mkdir ${JLINK_KERNEL_OUT_TOP}
	if [[ $PROJ == *"scx20"* ]]; then
		echo "ori project xxxxx"
		KCF_PROJ=${PROJ/scx20_/ }
		echo $KCF_PROJ
	else
		KCF_PROJ=${PROJ}
	fi

	make ARCH=arm -C kernel O=${JLINK_KERNEL_OUT} ${KCF_PROJ}_dt_defconfig
	make -C kernel O=${JLINK_KERNEL_OUT} ARCH=arm CROSS_COMPILE=arm-eabi- headers_install
	make -C kernel O=${JLINK_KERNEL_OUT} ARCH=arm CROSS_COMPILE=arm-eabi- -j8
	#make -C kernel O=${JLINK_KERNEL_OUT} ARCH=arm CROSS_COMPILE=arm-eabi- modules
	cp ${JLINK_KERNEL_OUT_TOP}/arch/arm/boot/Image $OUT_DIR/kernel

	out/host/linux-x86/bin/dtbTool -o $OUT_DIR/dt.img -s 2048 -p ${JLINK_DTC_OUT} ${JLINK_DTC_OUT2}
	out/host/linux-x86/bin/mkbootfs $OUT_DIR/root | out/host/linux-x86/bin/minigzip > $OUT_DIR/ramdisk.img
	out/host/linux-x86/bin/mkbootimg  --kernel $OUT_DIR/kernel --ramdisk $OUT_DIR/ramdisk.img --cmdline "console=ttyS1,115200n8" --base 0x00000000 --pagesize 2048 --dt $OUT_DIR/dt.img  --output $OUT_DIR/boot.img
fi

if [ $1 == 'recovery' ]; then

	echo $KROOT;
	JLINK_KERNEL_OUT_TOP=out/target/product/$PROJ/obj/JLINK_KERNEL
	JLINK_KERNEL_OUT=../out/target/product/$PROJ/obj/JLINK_KERNEL
	JLINK_DTC_OUT=out/target/product/$PROJ/obj/JLINK_KERNEL/scripts/dtc/
	JLINK_DTC_OUT2=out/target/product/$PROJ/obj/JLINK_KERNEL/arch/arm/boot/dts/
	mkdir ${JLINK_KERNEL_OUT_TOP}
	if [[ $PROJ == *"scx20"* ]]; then
		echo "ori project xxxxx"
		KCF_PROJ=${PROJ/scx20_/ }
		echo $KCF_PROJ
	else
		KCF_PROJ=${PROJ}
	fi

	make ARCH=arm -C kernel O=${JLINK_KERNEL_OUT} ${KCF_PROJ}_dt_defconfig
	make -C kernel O=${JLINK_KERNEL_OUT} ARCH=arm CROSS_COMPILE=arm-eabi- headers_install
	make -C kernel O=${JLINK_KERNEL_OUT} ARCH=arm CROSS_COMPILE=arm-eabi- -j8
	#make -C kernel O=${JLINK_KERNEL_OUT} ARCH=arm CROSS_COMPILE=arm-eabi- modules
	cp ${JLINK_KERNEL_OUT_TOP}/arch/arm/boot/Image $OUT_DIR/kernel

	out/host/linux-x86/bin/dtbTool -o $OUT_DIR/dt.img -s 2048 -p ${JLINK_DTC_OUT} ${JLINK_DTC_OUT2}
	out/host/linux-x86/bin/mkbootfs $OUT_DIR/recovery/root | out/host/linux-x86/bin/minigzip > $OUT_DIR/ramdisk-recovery.img
	out/host/linux-x86/bin/mkbootimg  --kernel $OUT_DIR/kernel --ramdisk $OUT_DIR/ramdisk-recovery.img --cmdline "console=ttyS1,115200n8" --base 0x00000000 --pagesize 2048 --dt $OUT_DIR/dt.img  --output $OUT_DIR/recovery.img


fi

if [ $1 == 'kconfig' ]; then
mkdir $KROOT
make -C kernel-3.18 O=$KROOT ARCH=arm64 CROSS_COMPILE=$TOP_ROOT/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/bin/aarch64-linux-android- ROOTDIR=$TOP_ROOT  ${PROJ}_debug_defconfig

fi
