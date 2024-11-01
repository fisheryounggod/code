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


# 类似R names
def names(df):
    """
    定义一幅图画多个时间序列的函数
    参数为：df
    """
    return df.columns.to_list()

# 通过关键词找匹配变量
def find_text(str_list, word):
    import re
    pattern = word
    matches = [s for s in str_list if re.search(pattern, s)]
    return matches


def find_key(df, word):
    """
    通过输入字符关键字查询对应变量的序号
    """
    column_list = df.columns.to_list()
    result = pd.DataFrame([(index, item) for index, item in enumerate(column_list) if word in item],
                            columns=['Index', 'Column Name'])
    return result


# 添加Pandas自定义select方法
def select(df,regex):
    """
    利用filter定义筛选列函数方法。
    参数：“regex”表达式
    """
    return df.filter(regex=regex, axis=1)


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


# export_data方法
def export_data(df, name):
    """
    定义函数导出df到00-data
    参数为：df, xxx.xlsx
    格式为：xlsx,csv,dta
    """
    import pandas as pd
    import numpy as np
    from pathlib import Path

    path = Path(name)
    if path.suffix.endswith("csv"):
        return df.to_csv(data_path+name, index=False)
        print("{}数据成功导出到00-data文件夹!".format(name))
    elif path.suffix.endswith("xlsx"):
        return df.to_excel(data_path+name, index=False)
        print("{}数据成功导出到00-data文件夹!".format(name))
    elif path.suffix.endswith("dta"):
        return df.to_stata(data_path+name, index=False)
        print("{}数据成功导出到00-data文件夹!".format(name))
    else:
        print("错误！只能是csv、xlsx和dta之一。")


# Pandas自定义type2date
def type2date(df, n=0):
    """
    # 转换指定列为日期并作为索引
    """
    try:             # 尝试转换为日期类型
        df['date'] = pd.to_datetime(df.iloc[:,n], errors='ignore')
    except:
        pass
    df.set_index('date', inplace=True)
    return df


def type2numeric(df, n=1):
    """
        2.	转换数字列：使用 pd.to_numeric() 转换为适当的数值类型。
        3.	使用 infer_objects()：让 Pandas 自动推断对象类型。
        4.	自动处理所有列：使用 apply() 结合自定义转换函数。
    """
    for col in df.columns[n:]:
        # 尝试转换为数字类型
        try:
            df[col] = pd.to_numeric(df[col], errors='ignore')
        except:
            pass

    return df


# 添加Pandas自定义export_sheet方法
def export_sheet(df, name, sheet):
    """
    定义函数导出df到00-data
    参数为：df
    格式为：xlsx/sheet
    """
    import pandas as pd
    import numpy as np
    with pd.ExcelWriter(data_path + name+".xlsx") as xlsx:
        df.to_excel(xlsx, sheet_name=sheet, index=False)
    print("数据成功导出到00-data文件夹{0}/{1}表格!".format(name,sheet))


def hp_cycle(y, lamb=1600):
    """
    HP滤波并返回cycle
    """
    import numpy as np
    import pandas as pd
    import matplotlib.pyplot as plt
    from statsmodels.tsa.filters.hp_filter import hpfilter
    cycle,trend = hpfilter(y, lamb)
    return cycle


def hp_trend(y, lamb=1600):
    """
    HP滤波并返回trend
    """
    import numpy as np
    import pandas as pd
    import matplotlib.pyplot as plt
    from statsmodels.tsa.filters.hp_filter import hpfilter
    cycle,trend = hpfilter(y, lamb)
    return trend


def hp_draw(y, lamb=1600):
    """
    HP滤波并画图
    根据Ravn and Uhlig(2002)的建议，
    参数lambda：
        - 对于年度数据lambda参数取值6.25(1600/4^4)，
        - 对于季度数据取值1600，
        - 对于月度数据取值129600(1600*3^4)。
    """
    import numpy as np
    import pandas as pd
    import matplotlib.pyplot as plt
    from statsmodels.tsa.filters.hp_filter import hpfilter
    cycle,trend = hpfilter(y, lamb)
    var_name = y.name
    # 绘制结果
    fig, ax = plt.subplots(figsize=(12, 3))
    y.plot(ax=ax, label = f'{var_name}: data')
    trend.plot(ax=ax, label=f'{var_name}: trend')
    cycle.plot(ax=ax, label=f'{var_name}: cycle')
    ax.set_xlabel("")
    ax.set_ylabel(f'{var_name}')
    ax.legend()
    plt.show()


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
