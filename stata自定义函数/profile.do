*--------------------------
* 修改自连玉君的 profile.do 文档
*--------------------------

*-说明：
* 此文件设定了每次启动 stata 时需要做的一些基本设定
* 你可以在此文件中添加你希望在stata启动时立刻执行的命令

*-不要自动更新
  set update_query  off

*-基本参数设定								
  set type double           // 设定 generate 命令产生的新变量为双精度类型
  set matsize 800           // 设定矩阵的维度为 2000x2000
  set scrollbufsize 2000000 // 结果窗口中显示的行数上限
  set more off, perma       // 关闭分页提示符
  
  set cformat  %4.3f  //回归结果中系数的显示格式
  set pformat  %4.3f  //回归结果中 p 值的显示格式      
  set sformat  %4.2f  //回归结果中 se值的显示格式     
  
  set showbaselevels off, permanently
  set showemptycells on, permanently
  set showomitted on, permanently
  set fvlabel on, permanently


*-PLUS 和 PERSONAL 文件夹  
*-有关这一部分的完整设定命令，请输入 help set 命令进行查看
  sysdir set PLUS "`c(sysdir_stata)'ado/plus"    // 外部命令的存放位置
  sysdir set PERSONAL "`c(sysdir_stata)'ado/personal"  // 个人文件夹位置
*-工作研究相关文件路径设置
 global research "/Users/mac/Library/CloudStorage/OneDrive-个人/Research" // Mac
//   global research "\\Mac\Home\Library\CloudStorage\OneDrive-个人\Research\" // Windows
  global mystata "$research/05-Code/05-Stata"
  global projects "$research/02-Analysis"
  global replication "$research/03-Replications"
  global stlog "$mystata/log"
  global mydo "$mystata/mydo"
  global mydta "$mystata/dta"
  global gitdata "/Users/mac/Github/fisheryounggod/gitdata/dta"
  
*-采用相似的方式，可添加其它允许stata搜索的目录
  adopath + $mystata/mydo
  adopath + $mystata/dta
  
*---------------------------
*-快速进入
*---------------------------
/*
  dis in w _n(2) "   "  
  dis _n _n _n in w "路径直达: |projects |stata | mydo | myda | mic  |"
  dis _n _n _n in w "相关教程: |NewPlan  |oop   | lian | chen | zhang|"
*/

*---------------------------
*-常用功能
*---------------------------
cap drop myFun // 定义函数显示常用代码
program myFun
  dis in w  "命令目录: " `"{stata myFun : myFun}"'
  dis in w  "START HERE: " `"{stata doedit "$mystata/starthere.do": 项目管理}"'
  dis in w  "软件快捷键: " `"{stata !cat "$mystata/mydo/STATA快捷键.do": cheatsheet}"'  
  dis in w  "Project创建/删除/锁定:" `"{stata GWD: NWP/RMP/GWD XXX}"' 
  dis in w  "常用Stata命令: " `"{stata doedit "$mystata/mydo/Stata常用操作.do": Command}"'
  dis in w  "修改profile: " `"{stata doedit "`c(sysdir_stata)'profile.do": profile}"'
  dis in w  "连享会教程 : " `"{stata lianxh: lianxh}"'
  dis in w  "songbl搜索: " `"{stata songbl: songbl}"'
  dis in w  "GDP数据: " `"{stata cngdf,year(2024) china: chinagdp}"'
  dis in w  "cuse打开数据: " `"{stata cuselist: cuselist}"'
  dis in w  "伍德里奇数据: " `"{stata bcuse crime1, clear: bcuse}"'
  dis in w  "国内股票数据: " `"{stata cntrade 1 300, index: cntrade}"'
  dis in w  "雅虎股票数据: " `"{stata help fetchyahooquotes: fetchyahoo}"'
  dis in w  "Stata示例数据: " `"{stata sysuse auto,clear: auto}"'
  dis in w  "ssc热门命令: " `"{stata ssc hot, n(10) : sschot}"'
  dis in w  "ISO 国家编码: " `"{stata help kountry : kountry}"'
  dis in w  "自动开启 log: " `"{stata auto_log : auto_log}"'
  dis in w  "显示常用网址: " `"{stata stata_source : stata_source}"'
end
*---------------------------
*-定义软链接
*---------------------------
  local p "mydo"
  cap program drop `p'
  program define `p'
    qui cd $mydo
  //cdout 
  end
  
  local p "mydta"
  cap program drop `p'
  program define `p'
    qui cd $mydta
  //cdout 
  end
  
  local p "cheatsheet"
  cap program drop `p'
  program define `p'
    !cat $mystata/mydo/STATA快捷键.do
  end
    
  local p "profile"
  cap program drop `p'
  program define `p'
    doedit "`c(sysdir_stata)'/profile.do"
  end
  
  local p "stata"
  cap program drop `p'
  program define `p'
    qui cd $mystata 
  //cdout 
  end

  local p "oop"
  cap program drop `p'
  program define `p'
    qui !open . 
  //cdout 
  end
  
  local p "command"
  cap program drop `p'
  program define `p'
    doedit "$mystata/mydo/Stata常用操作.do"
  //cdout 
  end

  local p "projects"
  cap program drop `p'
  program define `p'
    qui cd $projects 
  //cdout 
  end
  
  
  local p "gitdata"
  cap program drop `p'
  program define `p'
    qui cd $gitdata 
  //cdout 
  end
*------------------------------------------------------
*----- Stata 17 转码方法(一次性处理 .dta 转码问题) ----
*------------------------------------------------------
*-一次性转换当前工作路径下的所有文件
cap program drop uniall
program define uniall
*-说明: dofile 或 数据文件中包含中文字符时，需要转码才能正常显示	  
*-Step 1: 分析当前工作路径下的编码情况                         
  unicode analyze *                                         
*-Step 2: 设定转码类型                                          
  ua: unicode encoding set gb18030  // 中文编码                     
*-Step 3: 转换文件                                              
  ua: unicode translate *
end  

**# 工作路径设置 #1
cap program drop GWD
program GWD 
args Path 
if "`Path'" == "" {
    local Path = "`c(pwd)'"  // 如果为空，使用当前工作目录
}
else {
    local Path = "$projects/`Path'"  // 否则，构建路径
}
global Project `Path'
global Data `Path'/Data
global Figure `Path'/Out/Figure
global Table `Path'/Out/Table
global Raw `Path'/Raw
global Do `Path'/Do
global Log `Path'/Log
global File `Path'/File
dis in w  "当前项目：`Path'" 
dis in w  "检查路径: " `"{stata macro list : macro list}"'
end

**# 新建项目 #2
capture program drop NWP
program NWP
args FILE    
mkdir $projects/`FILE'
mkdir $projects/`FILE'/Do
mkdir $projects/`FILE'/Raw
mkdir $projects/`FILE'/Data
mkdir $projects/`FILE'/Log
mkdir $projects/`FILE'/File
mkdir $projects/`FILE'/Out
mkdir $projects/`FILE'/Out/Table
mkdir $projects/`FILE'/Out/Figure
doe $projects/`FILE'/Do/main.do
end

**# 删除项目 #3
capture program drop RMP
program RMP
args FILE 
!rm -rf $projects/`FILE'
end

**# 启动时自动创建日志文件 #4
capture program drop auto_log
program auto_log
local fn = subinstr("`c(current_time)'",":","-",2)
local fn1 = subinstr("`c(current_date)'"," ","",3)
log    using $stlog/log-`fn1'-`fn'.log, text replace
cmdlog using $stlog/cmd-`fn1'-`fn'.log, replace
end


**# 文档写入文本内容 #5
capture program drop Write
program Write
args file text
file open myfile using "`c(pwd)'/`file'.do", write
file write myfile "`text\n'"
file close myfile
end

**# 显示计量经济学资源汇总常逛网址 #6
capture program drop stata_source
program stata_source
  dis in w  "Stata官网资源：" ///
      `"{browse "http://www.stata.com": [Stata官网] }"' ///
      `"{browse "http://www.stata.com/support/faqs/":   [Stata-FAQ] }"' ///
      `"{browse "https://blog.stata.com/":      [Stata-Blogs] }"' ///
      `"{browse "http://www.stata.com/links/resources.html":   [Stata-资源链接] }"' _n
   
  dis in w  "Stata课程：" ///
     `"{browse "https://stats.idre.ucla.edu/stata/": [UCLA在线课程] }"' ///
     `"{browse "http://www.princeton.edu/~otorres/Stata/":        [Princeton在线课程] }"'  _n  
 
  dis in w  "Stata论坛：" ///
      `"{browse "http://www.statalist.com": [Stata-list] }"' ///
      `"{browse "https://stackoverflow.com":  [Stack-Overflow] }"' ///
      `"{browse "http://bbs.pinggu.org/": [经管之家-人大论坛] }"'       _n
   
 dis in w  "连玉君Stata：" ///
   `"{browse "https://gitee.com/arlionn":    [Stata连享会-码云] }"' ///
   `"{browse "https://www.aliyundrive.com/drive/folder/614ef2e4b4ab8eb08c7348058e0e0299273d3064": [Stata初级班] }"' ///
   `"{browse "https://pan.baidu.com/s/1P6ppM8RBNka8w5YAHtadSQ?pwd=6cpr 提取码: 6cpr": [Stata论文专题] }"' ///
   `"{browse "https://pan.baidu.com/s/1J6zAx0hE2YOwB-6eoPdBRA?pwd=6ktr 提取码: 6ktr": [Stata2017版音频] }"' ///
   `"{browse "https://www.aliyundrive.com/drive/folder/614efa02ac539b1a105e47bdbc380927e1c745f9":  [Stata高级班] }"' _n
   
  dis in w  "学术论文：" ///
    `"{browse "http://scholar.google.com/":     [谷歌学术] }"' ///
    `"{browse "http://scholar.cnki.net/":       [CNKI] }"' ///
   `"{browse "http://xueshu.baidu.com/":       [百度学术] }"'  _n
     
  dis in w  "空间计量及软件软件：" ///
      `"{browse "https://mp.weixin.qq.com/s/a3qQd8F-VJx-JctITAEawQ": [空间计量经济学入门：空间计量及Geoda应用] }"' ///
   `"{browse "https://mp.weixin.qq.com/s/a3qQd8F-VJx-JctITAEawQ": [空间计量及Matlab课程] }"' ///
   `"{browse "https://mp.weixin.qq.com/s/a3qQd8F-VJx-JctITAEawQ": [空间计量及Stata应用] }"' ///
   `"{browse "https://mp.weixin.qq.com/s/a3qQd8F-VJx-JctITAEawQ": [空间计量及ArcGis应用] }"' ///
   `"{browse "https://mp.weixin.qq.com/s/a3qQd8F-VJx-JctITAEawQ": [应用空间计量经济学：方法与应用》] }"' ///
   `"{browse "https://mp.weixin.qq.com/s/XWEBubvCfdmM2xJMakc2PA": [Stata从入门到进阶；初级计量经济学] }"' ///
   `"{browse "https://mp.weixin.qq.com/s/yQAA8tZmkwEPr8LxS5R_yw": [高级计量经济学及Eviews应用] }"' ///
   `"{browse "https://mp.weixin.qq.com/s/lxJN0bl_-_LuQkshHE97JA": [高级计量经济学及Stata应用：Stata回归分析与应用] }"' ///
   `"{browse "https://mp.weixin.qq.com/s/ljbKqizleuJN5sB5HajDDQ": [零基础学Python] }"'  _n 
end

**# 自定义画图函数: tsline #7
cap program drop  mytsline
program mytsline
args var
tsline `var', title("`var'") xlab(,angle(45)) xtitle("")
end

**# 自定义数据导出gitdata函数 #8
cap program drop gitdata
program gitdata
args var
local path "`c(pwd)'"
local url "/Users/mac/Github/fisheryounggod/gitdata/dta"
local prefix = substr("`var'", 1, 1)
cap mkdir "`url'/`prefix'"
qui save "`url'/`prefix'/`var'.dta", replace
qui cd "/Users/mac/Github/fisheryounggod/gitdata"
!git add `url'/`prefix'/`var'.dta
!git commit -m  "add `var'"
!git push origin main
qui cd `path'
end 

// work 
cd $projects
