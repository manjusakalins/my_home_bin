adb remount;
adb push modem_1_wg_n.img /system/etc/firmware/;
adb push catcher_filter_1_wg_n.bin /system/etc/firmware/;

adb push modem_1_lwg_n.img /system/etc/firmware/;
adb push dsp_1_lwg_n.bin /system/etc/firmware/;
adb push catcher_filter_1_lwg_n.bin /system/etc/firmware/;
adb push modem_1_ltg_n.img /system/etc/firmware/;
adb push dsp_1_ltg_n.bin /system/etc/firmware/;
adb push catcher_filter_1_ltg_n.bin /system/etc/firmware/;
adb shell mkdir /system/etc/mddb
adb push BPLGUInfoCustomAppSrc* /system/etc/mddb/;
adb push DbgInfo* /system/etc/mddb/;

adb push catcher_filter_3_3g_n.bin /system/etc/firmware/;
adb push fsm_rf_df_3_3g_n.img /system/etc/firmware/;
adb push boot_3_3g_n.rom /system/etc/firmware/;
adb push fsm_cust_df_3_3g_n.img /system/etc/firmware/;
adb push fsm_rw_df_3_3g_n.img /system/etc/firmware/;
adb push modem_3_3g_n.img /system/etc/firmware/;

