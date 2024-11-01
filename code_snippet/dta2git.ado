* 自定义函数将指定目录dta文件复制到gitdata/dta
cap program drop  dta2git
program dta2git
	fs 	*.dta // 获取当前文件下所有dta文件列表
	foreach var in `r(files)' {
		local url "/Users/mac/Github/fisheryounggod/gitdata/dta"
		local prefix = substr("`var'", 1, 1)
		local path "`url'/`prefix'"
		cap mkdir `path'
		!cp "`url'/`prefix'/`var'.dta" `path'
		}
end 
