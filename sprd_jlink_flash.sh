adb reboot bootloader;
fastboot flash splloader u-boot-spl-16k.bin
fastboot flash uboot u-boot.bin
fastboot flash prodnv prodnv.img
fastboot flash wfixnv1 nvitem.bin
fastboot flash wcnfixnv1 nvitem_wcn.bin

fastboot flash wmodem SC7702_sc7731g_band128_AndroidM.dat
fastboot flash wdsp DSP_DM_G2.bin
fastboot flash wcnmodem SC8800G_x30g_wcn_dts_modem.bin
fastboot flash boot boot.img
fastboot flash recovery recovery.img
fastboot flash custom custom.img
fastboot flash persist persist.img
fastboot flash userdata userdata.img
fastboot flash logo bootlogo.bmp
fastboot flash cache cache.img
fastboot flash sysinfo sysinfo.img
fastboot flash system system.img

first_w="W"
fastboot flash splloader $first_w"Z"*
fastboot flash uboot $first_w"U"*
fastboot flash boot $first_w"B"*
fastboot flash cache $first_w"H"* 
fastboot flash userdata $first_w"S"* 
fastboot flash recovery $first_w"R"* 
fastboot flash logo $first_w"O"* 
fastboot flash custom $first_w"C"* 
fastboot flash wfixnv1 $first_w"N"* 
fastboot flash wcnfixnv1 $first_w"T"*
fastboot flash persist $first_w"E"*
fastboot flash prodnv $first_w"V"* 
fastboot flash sysinfo $first_w"J"*
fastboot flash system $first_w"Y"* 
