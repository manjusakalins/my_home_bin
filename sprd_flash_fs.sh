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

