# BOP数据导入：（亿USD）
rio::import("/Users/mac/Library/CloudStorage/OneDrive-个人/DATA/中国国际收支（BOP）/中国国际收支平衡表时间序列(BPM6).xlsx",sheet = "年度BOP（美元） ",range = "A4:BW133") %>% 
    filter_all(any_vars(!is.na(.))) %>%  # 移除全为空的行
    mutate(names=paste(row_number(),项目),.before = 1) %>% 
    column_to_rownames(var = "names") %>% 
    select(-项目) %>% 
    t %>% #行列转置
    as.data.frame %>% 
    mutate(year=row.names(.),.before=1) %>% 
    as.tibble() %>% 
    mutate_all(as.numeric) -> bop_usd 
bop_usd %>% head 