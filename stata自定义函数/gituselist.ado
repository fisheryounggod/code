*! 显示数据库中的所有数据集
cap prog drop gituselist
prog define gituselist
    !/opt/homebrew/bin/tree "/Users/mac/Github/fisheryounggod/gitdata/dta"
end
