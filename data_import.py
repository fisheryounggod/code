#%%
from myfun.myfun import * # 自定义函数包
# bop = pd.read_csv("https://fisheryounggod.github.io/gitdata/csv/china_bop_qr.csv")
# gdp = pd.read_csv("https://fisheryounggod.github.io/gitdata/csv/china_gdp_year.csv")
gdp_qr = pd.read_csv("https://fisheryounggod.github.io/gitdata/csv/china_gdp_qr.csv")

print(gdp_qr)

# rename2(select(bop1,"经常"),"1. 经常账户","CA")
# gdp = select(gdp1,"时间|国民总收入")
# gdp = rename2(gdp,"国民总收入(亿元)","GDP")
# gdp = rename2(gdp,"时间","year")
# gdp
# gdp.plot(y="GDP", x="year", figsize=(15,8),title="GDP(亿元)")

# gdp_qr = pd.read_csv("gdp_qr.csv",sep="\t")
# qr = pd.date_range(start='1992-01-01', periods=131, freq='Q')  # 生成data_range

# gdp_qr = pd.DataFrame(data=gdp_qr.values, index=qr,columns=gdp_qr.columns)
# gdp_qr.to_csv(data_path+"/csv/gdp_qr.csv")
# %whos
# bop = pd.read_csv("https://fisheryounggod.github.io/gitdata/csv/china_bop6.csv")
# bop

# qr = pd.date_range(start='1998-01-01', periods=104, freq='Q')  # 24个月的数据
# qr
# bop1 = bop1.set_index(qr)
# bop1.to_csv(data_path+"/csv/china_bop_qr.csv")