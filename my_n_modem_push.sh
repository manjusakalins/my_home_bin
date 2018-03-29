adb remount;
adb push modem_1_wg_n.img /system/vendor/firmware/;
adb push catcher_filter_1_wg_n.bin /system/vendor/firmware/;

adb push modem_1_lwg_n.img /system/vendor/firmware/;
adb push dsp_1_lwg_n.bin /system/vendor/firmware/;
adb push catcher_filter_1_lwg_n.bin /system/vendor/firmware/;
adb push modem_1_ltg_n.img /system/vendor/firmware/;
adb push dsp_1_ltg_n.bin /system/vendor/firmware/;
adb push catcher_filter_1_ltg_n.bin /system/vendor/firmware/;
adb shell mkdir /system/vendor/etc/mddb
adb push BPLGUInfoCustomAppSrc* /system/vendor/etc/mddb/;
adb push DbgInfo* /system/vendor/etc/mddb/;
adb push BPMdMetaDatabase* /system/vendor/etc/mddb/;
adb push mdm_layout_desc_1_lwg_n.dat /system/vendor/etc/mddb/
adb push mdm_layout_desc_1_ltg_n.dat /system/vendor/etc/mddb/

adb push catcher_filter_3_3g_n.bin /system/vendor/firmware/;
adb push fsm_rf_df_3_3g_n.img /system/vendor/firmware/;
adb push boot_3_3g_n.rom /system/vendor/firmware/;
adb push fsm_cust_df_3_3g_n.img /system/vendor/firmware/;
adb push fsm_rw_df_3_3g_n.img /system/vendor/firmware/;
adb push modem_3_3g_n.img /system/vendor/firmware/;

