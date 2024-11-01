#%%
import time
import requests

# 解析URL，提取参数及其值
url = "https://data.stats.gov.cn/easyquery.htm"

params = {
    'm': 'QueryData',
    'dbcode': 'fsnd',
    'rowcode': 'zb',
    'colcode': 'reg',
    'wds': '[{"wdcode":"sj","valuecode":"2021"}]',
    'dfwds': '[{"wdcode":"zb","valuecode":"A0502"}]',
    'k1': str(int(time.time() * 1000)),
    'h': '1'
}

# 发送GET请求
response = requests.get(url, params=params, verify=False)

# 输出响应内容
print(response.text)

data = response.json()


#%%
def handle_data_to_dict(wdnode):
    """
    处理数据字典
    :param wdnode:
    :return:
    """
    zb_dict = {}
    reg_dict = {}
    for item in wdnode:
        if item["wdcode"] == "zb":
            for node in item["nodes"]:
                # print(node["cname"], node["code"], node["unit"])
                zb_dict[node["code"]] = f'{node["cname"]}({node["unit"]})'
        if item["wdcode"] == "reg":
            for node in item["nodes"]:
                # print(node["cname"], node["code"])
                reg_dict[node["code"]] = node["cname"]
    return zb_dict, reg_dict

#%%
import requests 

def Tools(url):     
    # 模拟浏览器请求 防止被反爬  请求头     
    headers = {         
               'Referer': 'www.stats.gov.cn/tjsj/pcsj/r…',        
               'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.114 Safari/537.36 Edg/91.0.864.59'     }     
    response = requests.get(url, headers=headers)     
    return response

def Save(name, urls):     
    '''     
    请求Excel下载地址 并且保存到代码同路径的 index文件夹     :param name: 
    存储的名称     :param 
    urls: xls 
    下载地址     :
    return:     
    '''     
    response = Tools(urls).content  # 返回的是字节     
    f = open('{}.xls'.format(name), 'ab')     
    f.write(response)     
    f.close()     
    print('{}下载完成.....'.format(name))
    
# %%
url = 'http://www.stats.gov.cn/tjsj/pcsj/rkpc/6rp/lefte.htm'
response = Tools(url).content.decode('gbk')
html = etree.HTML(response) # 创建HTML对象
title = html.xpath('//ul[@id="foldinglist"]/li/a/text()') # text获取该标签内的文字内容
details = html.xpath('//ul[@id="foldinglist"]/li/a/@href') [:-13]# 下载地址的后缀

for t, d in zip(title, details):     
    urls = 'www.stats.gov.cn/tjsj/pcsj/rkpc/6rp/' + d     
    Save(t, urls) 
# %%
