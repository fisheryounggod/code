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


def penn_tri_data():
    # penn_table_variables = {
    #     'countrycode': '国家代码，通常是 ISO 3 位国家代码（如 USA 表示美国）',
    #     'country': '国家名称',
    #     'currency_unit': '货币单位（如美元、欧元等）',
    #     'year': '年份',
    #     'rgdpe': '实际国内生产总值（支出法），以 2017 年不变价格衡量',
    #     'rgdpo': '实际国内生产总值（生产法），以 2017 年不变价格衡量',
    #     'pop': '人口，国家的总人口数',
    #     'emp': '就业人数',
    #     'avh': '平均每年工作时长（小时）',
    #     'hc': '人力资本指数（基于平均受教育年限和回报率）',
    #     'ccon': '实际私人消费支出',
    #     'cda': '实际资本折旧额',
    #     'cgdpe': '实际国内生产总值（支出法）',
    #     'cgdpo': '实际国内生产总值（生产法）',
    #     'cn': '实际净资本存量',
    #     'ck': '实际资本存量',
    #     'ctfp': '总要素生产率（根据支出法）',
    #     'cwtfp': '调整后的总要素生产率（根据支出法，调整后的误差）',
    #     'rgdpna': '实际国内生产总值（国家账户法），以 2017 年不变价格衡量',
    #     'rconna': '实际私人消费（国家账户法），以 2017 年不变价格衡量',
    #     'rdana': '实际国内总资本形成（国家账户法）',
    #     'rnna': '实际净资本形成（国家账户法）',
    #     'rkna': '实际资本存量（国家账户法）',
    #     'rtfpna': '实际总要素生产率（国家账户法）',
    #     'rwtfpna': '实际加权总要素生产率（国家账户法）',
    #     'labsh': '劳动收入份额',
    #     'irr': '内部回报率（投资回报率）',
    #     'delta': '资本折旧率',
    #     'xr': '市场汇率（相对于美元）',
    #     'pl_con': '私人消费的购买力平价（PPP）',
    #     'pl_da': '总资本形成的购买力平价（PPP）',
    #     'pl_gdpo': 'GDP（生产法）的购买力平价（PPP）',
    #     'i_cig': 'CPI 和 GDP 平均值之间的指数（货币条件）',
    #     'i_xm': '出口和进口价格指数之间的平均值',
    #     'i_xr': 'CPI 和汇率之间的偏差指标',
    #     'i_outlier': '异常值的标识符（1 表示异常）',
    #     'i_irr': '投资回报率的标识符（1 表示异常）',
    #     'cor_exp': '国家账户数据的经验调整',
    #     'statcap': '国家统计能力指标',
    #     'csh_c': '消费在 GDP 中的份额',
    #     'csh_i': '投资在 GDP 中的份额',
    #     'csh_g': '政府支出在 GDP 中的份额',
    #     'csh_x': '出口在 GDP 中的份额',
    #     'csh_m': '进口在 GDP 中的份额',
    #     'csh_r': '农业在 GDP 中的份额',
    #     'pl_c': '私人消费的相对价格',
    #     'pl_i': '投资的相对价格',
    #     'pl_g': '政府支出的相对价格',
    #     'pl_x': '出口的相对价格',
    #     'pl_m': '进口的相对价格',
    #     'pl_n': '净出口的相对价格',
    #     'pl_k': '资本存量的相对价格',
    #     'code': '潘恩表的国家代码',
    #     'ERR': '汇率制度',
    #     'MI': '货币政策独立性',
    #     'OPEN': '资本自由度度'
    # }
    import pandas as pd
    import numpy as np
    df = pd.read_excel(data_path+"penn_tri.xlsx")
    return(df)
