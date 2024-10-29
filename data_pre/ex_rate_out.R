# 中美汇率数据
ex_rate  <- rio::import("/Users/mac/Library/CloudStorage/OneDrive-个人/Research/04-Data/07-e-汇率/月度中美汇率（81-24）.xlsx")  %>%  
    select(日期,收市) %>% 
    mutate(year=as.numeric(substr(日期,1,4))) %>%  # 生成时间格式为年度
    mutate(qtr=zoo::as.yearqtr(日期))  %>% 
    rename(date=日期) %>% 
    rename(ex_rate=收市)
ex_rate %>% head

ex_rate %>% # 转为季度数据
    select(year,everything()) %>% 
    group_by(year) %>% 
    summarise(ex_rate =mean(ex_rate))  -> ex_rate_year

ex_rate %>% # 转为季度数据
    select(qtr,everything()) %>% 
    group_by(qtr) %>% 
    summarise(ex_rate =mean(ex_rate))  -> ex_rate_qr

rio::export(ex_rate_year,"/Users/mac/Github/fisheryounggod/gitdata/csv/ex_rate_year.csv")
rio::export(ex_rate_qr,"/Users/mac/Github/fisheryounggod/gitdata/china/ex_rate_qr.csv")

ex_rate_qr %>% head