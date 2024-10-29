use data_gpr_export,clear
%head
cap drop month1

// gen month1=string(month,"%tm")  // Stata系统时间转换为字符串，方便导出其他设备
ds
list mon* in 1/10
tsset month
tsline GPR
tsline GPRC_CHN
tsline GPRHC_CHN
tsline GPRHC_USA
tsline GPRC_UKR
tsline GPRC_RUS
