source("/Users/mac/source.R") # 预先配置R+Python环境
# # 导入Python包
library(reticulate)
os <- reticulate::import("myfun")   # 调用函数：os$listdir(".")
pd <- reticulate::import("pandas")

library(tidyverse)

# BOP数据导入：（亿USD）
(bop_usd <- rio::import("https://fisheryounggod.github.io/gitdata/china/bop/bop_gdp_qr.csv")  ) %>% head




# 提取贸易数据
bop_usd %>% 
    rename(import=`9 借方`,export=`8 贷方`) %>% 
    select(year,import,export)  %>% 
    left_join(ex_rate) %>% 
    left_join(gdp) %>% 
    tidyr::drop_na() %>% # 移除空值
    select(year,everything()) %>% 
    mutate_at(c("import","export"),~.x * ex_rate) -> trade # 货币换为RMB
trade 

# 进出口占比
trade %>% 
    mutate(imp.of.gdp = (-import)/GDP,
           exp.of.gdp = (export)/GDP,
           trade.of.gdp = (-import+export)/GDP) %>% 
    select(contains("year")|contains(".of."))-> trade.ratio
trade.ratio

trade.ratio %>% summarise(mean(trade.of.gdp))  # 全样本均值
trade.ratio %>% filter(year>1994) %>% summarise(mean(trade.of.gdp)) # 1994-2023年均值
trade.ratio %>% filter(year>2018) %>% summarise(mean(trade.of.gdp)) # 1994-2023年均值

# 贸易结构变化
ggplot(trade.ratio, aes(x = year,y = trade.of.gdp)) + # 画图
    geom_line(linewidth=1) +
    geom_hline(yintercept = 0.38, linetype = "dashed", color = "blue") + # 添加水平线
    scale_x_continuous(limits = c(1980, 2024), breaks = c(seq(1980, 2024, by = 2))) + # 设置x轴的范围
    geom_text(aes(x = 2020, y = .42, label = "贸易占比大于40%为外循环"), color = "red",family = "SimSong") + # 添加文字标注
    scale_y_continuous(labels = function(x) scales::percent(x*100, scale = 1, accuracy = 0.1),
                       limits = c(0.1, 0.7), breaks = seq(0.1, 0.7, by = 0.1))  + # 将纵坐标数值乘以100并显示为百分比，设置纵坐标范围和刻度间隔
    ggtitle(expression("中国贸易结构变化（1981-2023）")) + # 标题设置
    labs(x = "", y = "") +
    theme(panel.border = element_blank())  + # 去掉整个图表外框
    theme_economist(base_family = "SimHei")  + # 设置图表风格为Stata风格
    theme(axis.text.x = element_text(angle = 45)) + # 将 x 轴标签旋转45
    theme(axis.text.y = element_text(angle = 0))  # 将 y 轴标签旋转为横向

# 三条曲线
trade.ratio %>% pivot_longer(-year, names_to = "type", values_to = "trade.ratio") -> trade.ratio.l # 变为长表，方便画图
ggplot(trade.ratio) + 
    geom_line(aes(x=year, trade.ratio,color=type),size=1.5) + 
    scale_y_continuous(labels = function(x) scales::percent(x*100, scale = 1, accuracy = 0.1), 
                       limits = c(0.1, 0.6), breaks = seq(0.1, 0.6, by = 0.05))  + # 将纵坐标数值乘以100并显示为百分比，设置纵坐标范围和刻度间隔
    scale_x_continuous(limits = c(1994, 2024), breaks = seq(1994, 2024, by = 2))  +
    ggtitle(expression("EX/IM/Trade of GDP( 1994-2023)")) + # 标题设置
    theme(axis.text.x = element_text(angle = 45)) + # 将 x 轴标签旋转45
    theme(axis.text.y = element_text(angle = 0))  + # 将 y 轴标签旋转为横向
    scale_color_manual(values = c("red" = "Export", "green" = "Import", "blue"="Trade")) +
    theme_economist() +
    labs(x = "", y = "") +
    guides(color = guide_legend(title = "Type")) # 添加图例标题


# 增速变化
trade %>% 
    mutate_at(c("import","export","GDP"), growth_rate) %>% 
    rename(import_growth = import, 
           export_growth = export,
           gdp_growth = GDP) %>% 
    select(-ex_rate) %>% 
    drop_na  %>% 
    left_join(trade) -> trade.growth 
trade.growth 

trade.growth %>% select()
ggplot(data=trade.growth) +
    geom_bar(aes(x=year, y= import,color="red"),stat="identity") + 
    geom_bar(aes(x=year, y= export,color="green"),stat="identity") 

# 绘制增长率图形
trade.growth %>% 
    select(1:3) %>% 
    longer(year) %>% ggplot(aes(x = year, y = value, color=key)) +
    geom_line() 

# 绘制柱形图
trade.growth %>% 
    select(1:4) %>% 
    longer(year) %>% ggplot(aes(x = year, y = value, group=key, color=key)) +
    geom_bar(stat="identity") + 

# 绘制水平值图形
trade.growth %>% 
    select(c(1,5,6,8)) %>% 
    longer(year) %>% ggplot(aes(x = year, y = value, color=key)) +
    geom_line() 

# 贸易条件变动: From WDI (TT.PRI.MRCH.XD.WD) 
library(WDI) 
WDI(country=c("IND","JPN","USA","CHN"),
    indicator="TT.PRI.MRCH.XD.WD",
    start=1990, end=2023) -> wdi
wdi 
wdi %>% 
    rename(TOT=TT.PRI.MRCH.XD.WD) %>%
    select(!starts_with("iso")) %>% 
    as.data.table -> tot

tot[country=="China"][1:15,ggplot() + geom_bar(aes(year,TOT),stat = "identity") + labs(title="TOT of China") + theme_light()]
                                           
tot[country=="China"][1:15,ggplot() + geom_line(aes(year,TOT)) + labs(title="TOT of China") + theme_light()]
