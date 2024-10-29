# BOP
bop_qr  <-  rio::import("https://fisheryounggod.github.io/gitdata/csv/china_bop_qr.csv") %>% 
    rename(date1=`V1`)  %>% 
    mutate(qtr=zoo::as.yearqtr(date))  -> bop_qr

bop_qr    %>% 
    select(date1, qtr, "1. 经常账户")  %>% 
    rename(CA="1. 经常账户") -> ca_qr 
ca_qr %>% head
ex_rate_qr %>% head

merge(ca_qr,ex_rate_qr,on="qtr")  %>% 
mutate(CA_RMB=CA*ex_rate)  -> bop_rmb
bop_rmb %>%  head