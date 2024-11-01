# BOP
install.packages("janitor")
library(janitor)

rio::import("https://fisheryounggod.github.io/gitdata/china/bop/dolar_bop_qr.csv") %>% 
    rename(date1=`V1`)  %>% 
    # clean_names  %>%  # names
    mutate(qtr=zoo::as.yearqtr(date))  -> bop_qr

# 中美汇率数据
rio::import("/Users/mac/Library/CloudStorage/OneDrive-个人/Research/04-Data/07-e-汇率/月度中美汇率（81-24）.xlsx")  %>%  
    select(日期,收市) %>% 
    mutate(year=as.numeric(substr(日期,1,4))) %>%  # 生成时间格式为年度
    mutate(qtr=zoo::as.yearqtr(日期))  %>% 
    rename(date=日期) %>% 
    rename(ex_rate=收市)  %>% 
    group_by(qtr) %>% 
    summarise(ex_rate =mean(ex_rate))  -> ex_rate_qr
ex_rate_qr %>% head

# GDP(亿元)
rio::import("https://fisheryounggod.github.io/gitdata/china/gdp/gdp_qr.csv")  %>% 
    mutate(qtr=zoo::as.yearqtr(date)) -> gdp_qr

# 数据合并
bop_qr %>% inner_join(ex_rate_qr, by = "qtr") %>% 
    # select(date1, qtr, "1. 经常账户","ex_rate")  %>% 
    mutate_if(is.numeric, ~ . * ex_rate) %>% # 对所有数值变量执行统一操作
    select(-ex_rate) -> bop_rmb  
# bop_rmb  %>% rio::export("/Users/mac/Github/fisheryounggod/gitdata/china/bop/bop_rmb.csv") # 导出BOP（RMB）

## GDP_BOP_usd
(gdp_usd <- gdp_qr %>% 
        inner_join(ex_rate_qr, by = "qtr") %>% 
        mutate(gdp_usd = GDP/ex_rate) ) %>% head

gdp_usd %>% 
    inner_join(bop_rmb,by = 'qtr') -> gdp_bop_usd

gdp_bop_usd %>% # 导出BOP-GDP（亿美元）
    rio::export("/Users/mac/Github/fisheryounggod/gitdata/csv/gdp_bop_usd_qr.csv")