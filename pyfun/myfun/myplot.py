
# 添加Pandas自定义tsline
def tsline(df):
    """
    定义一幅图画多个时间序列的函数
    参数为：df
    """
    if df.index.name is None:
        df = df.type2date()
    ax = df.plot(figsize=(12, 4))  # df线图
    plt.axhline(y=0, color='black', linestyle='--')  # 添加水平线 y=0
    plt.title('Time Series Plot')
    plt.ylabel('Values')
    plt.legend(title='Legend')
    plt.show()  # 显示图表


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
