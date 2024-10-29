# GDP数据：（亿RMB）
gdp_qr  <-  rio::import("https://fisheryounggod.github.io/gitdata/csv/china_gdp_qr.csv") %>% 
    rename(GDP=`国内生产总值`) %>% 
    rename(date=`V1`) %>% 
    select(date,GDP) 
gdp_qr
rio::export(gdp_qr,"/Users/mac/Github/fisheryounggod/gitdata/china/gdp_qr.csv")
