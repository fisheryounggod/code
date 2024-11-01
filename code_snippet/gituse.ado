* 自定义数据调用
cap prog drop gituse
prog define gituse
	version 14.0
	if `"`0'"' == "" {
		error 198
	}
	local 0 `"using `0'"'
	syntax using/ [, Clear Web Savetosystem]
	if "`web'" != ""{
		local url "https://fisheryounggod.github.io/gitdata/dta"
	}
	else{
		local url "/Users/mac/Github/fisheryounggod/gitdata/dta"
	}
	local prefix = substr("`using'", 1, 1)
	use `"`url'/`prefix'/`using'"', `clear'
	if "`savetosystem'" != ""{
		local syspath "`c(sysdir_plus)'"
		save "`syspath'`prefix'/`using'", replace
	}
end