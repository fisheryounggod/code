**# 自定义数据导出gitdata函数 #1
cap program drop gitdata
program gitdata
args var
// local url "/Users/mac/Github/fisheryounggod/gitdata/dta/"
local path "`c(pwd)'"
local url "/Users/mac/Github/fisheryounggod/gitdata/dta"
local prefix = substr("`var'", 1, 1)
cap mkdir "`url'/`prefix'"
qui save "`url'/`prefix'/`var'.dta", replace
qui cd "/Users/mac/Github/fisheryounggod/gitdata"
!git add `url'/`prefix'/`var'.dta
!git commit -m  "update `var'"
!git push origin main
qui cd `path'
end 


