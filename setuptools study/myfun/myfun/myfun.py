import sys
sys.path.append("/Users/mac/Library/CloudStorage/OneDrive-个人/Research/05-Programming/01-Python")
data_path = "/Users/mac/Github/fisheryounggod/gitdata"

import pandas as pd
import numpy as np
from datetime import datetime
import pandas_datareader.data as web
import wbgapi as wb
import scipy.optimize as solver
import matplotlib.pyplot as plt



# pandas 变量重命名
def rename2(df,oldname, newname):
    df = df.rename(columns={oldname: newname})
    return df
def renamere(df, oldname, newname):
    """正则重命名
    Args:
        df (dataframe): df
        newname (dataframe): 新名称
        oldname (dataframe): 旧名称
    Returns:
        dataframe: 返回修改名称后的DataFrame
    """
    df = df.rename(columns=lambda x: re.sub(oldname, newname, x)) 
    return df

def iso23(iso2):
    """
    将ISO2转为ISO3国家代码
    """
    import pycountry
    return pycountry.countries.get(alpha_2=iso2).alpha_3

def iso3(country,n=3):
    """
     输入字符串模糊查找国家¶ios3
    """
    import pycountry
    try:
        return pycountry.countries.search_fuzzy(country)[0].alpha_3  # 模糊查找国家¶
    except LookupError as e:
        return f"{e} not found!"

def mmerge(dfs, index_A, index_B, how='outer'):
    """
    将多个数据框按照 A,B 两个索引进行列合并
        :param dfs: 包含多个 Pandas 数据框的列表
        :param index_A: 索引 A 名称
        :param index_B: 索引 B 名称
        :return: 合并后的 Pandas 数据框
    """
    result = dfs[0]
    for df in dfs[1:]:
        result = pd.merge(result, df, on=[index_A, index_B], how=how)
    return result


def replace_month(date_str):
    """
    用来替换月份缩写并格式化为 YYYY-MM
    """
    month_dict = {
        'Jan': '01', 'Feb': '02', 'Mar': '03', 'Apr': '04',
        'May': '05', 'Jun': '06', 'Jul': '07', 'Aug': '08',
        'Sep': '09', 'Oct': '10', 'Nov': '11', 'Dec': '12'
    }
    for abbr, num in month_dict.items():
        date_str = date_str.replace(abbr, num)
    return re.sub(r"(\d{4})(\d{2})", r"\1-\2", date_str)


def reg(df, yvar, xvars):
    """
    OLS线性回归:
    sm.OLS(Y, X, missing='drop').fit()
    --> result.summary()
    """
    import pandas as pd
    import statsmodels.api as sm
    data=pd.concat([df[yvar], df[xvars]], axis=1)
    Y = df[yvar]
    x = df[xvars]
    X = sm.add_constant(x)
    result = sm.OLS(Y, X, missing='drop').fit()
    # return yvar,result.params[1]
    print("{}~{}：系数 = {:.3f}, p值: {:.3f}".format(yvar, xvars, result.params[1], result.pvalues[1]))
    print(result.summary())


def import_data(path,sheet=0):
    """
    读取含有中文的csv格式。
    """
    import pandas as pd
    import numpy as np
    from pathlib import Path
    path = Path(path)
    if path.suffix.endswith("csv"):
        return pd.read_csv(path)
    elif path.suffix.endswith("xls"):
        return pd.read_excel(path,sheet_name=sheet)
    elif path.suffix.endswith("xlsx"):
        return pd.read_excel(path,sheet_name=sheet)
    elif path.suffix.endswith("dta"):
        return pd.read_stata(path)
    else:
        print("数据格式不包含在csv、xls，xlsx和dta之中。")


def find_text(str_list, word):
    import re
    pattern = word
    matches = [s for s in str_list if re.search(pattern, s)]
    return matches


def ggplot(df,x,y,label):
    """
    ggplot2 格式Python画图
    """
    from plotnine import ggplot, aes, geom_col, geom_text,lims, position_dodge, geom_point, geom_line
    import matplotlib.pyplot as plt
    from matplotlib.font_manager import FontProperties
    # 指定中文字体路径
    font = FontProperties(fname='/System/Library/Fonts/Supplemental/Songti.ttc')  # macOS 的示例路径，Windows/Linux 需要相应调整
    # 设置 `matplotlib` 字体
    plt.rcParams['font.sans-serif'] = ['Songti']  # 使用黑体
    plt.rcParams['axes.unicode_minus'] = False    # 解决负号显示问题
    dodge_text = position_dodge(width=0.9)     #调整文本位置
    plot = (
        ggplot(df, aes(x=x,
                       y=y,
                       color=label,
                       group=label)) #类别填充颜色
        + geom_line(aes(color='factor(label)'))
        # + geom_col(position='dodge',
        #            show_legend=False)   # modified
        # + geom_text(aes(y=-.5, label=label),
        #             position=dodge_text,
        #             color='gray',  #文本颜色
        #             size=8,   #字号
        #             angle=30, #文本的角度
        #             va='top')
        # + lims(y=(-5, 60))
    )
    print(plot)

# 添加Pandas自定义names方法
from pandas.api.extensions import register_dataframe_accessor
@register_dataframe_accessor("names")
class CustomAccessor:
    def __init__(self, pandas_obj):
        self._obj = pandas_obj  # The DataFrame being passed in
    def __call__(self):
        """
        定义一幅图画多个时间序列的函数
        参数为：df
        """
        return self._obj.columns.to_list()
