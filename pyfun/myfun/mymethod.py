
# 批量添加Pandas自定义my函数方法
from pandas.api.extensions import register_dataframe_accessor
@register_dataframe_accessor("mymethod")
class CustomAccessor:
    def __init__(df, pandas_obj):
        """
        # Using the custom methods
        - df.custom.tsline(x='date')
        - df.custom.summary_statistics()
        - rolling_avg_df = df.custom.rolling_average(column='value1', window=3)
        - print(rolling_avg_df)
        """
        df = pandas_obj  # The DataFrame being passed in
    def summary_statistics(df):
        """
        计算并返回DataFrame的基本统计信息
        """
        stats = df.describe()
        print("Summary Statistics:")
        print(stats)
        return stats
    def rolling_average(df, column, window=3):
        """
        计算指定列的滚动平均值
        参数：column - 要计算的列名, window - 滚动窗口大小
        """
        df[f'{column}_rolling'] = df[column].rolling(window=window).mean()
        print(f"Rolling average for {column} with window size {window}:")
        return df[[column, f'{column}_rolling']]