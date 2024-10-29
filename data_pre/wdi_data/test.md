---
jupyter:
  jupytext:
    cell_metadata_filter: -all
    custom_cell_magics: kql
    main_language: R
    text_representation:
      extension: .md
      format_name: markdown
      format_version: '1.3'
      jupytext_version: 1.11.2
  kernelspec:
    display_name: R
    language: R
    name: ir
---

```r

# library(bruceR)
# library(formatR)
library(ggplot2)
library(rio)
# library(tidyverse)
# library(showtext) # Êî?ÊåÅ‰∏≠Êñ?
# showtext_auto()
# library(data.table)

```

```py3
relation <- import("relation_with_china_year.xlsx",class = "data.table")
relation

```

```py3
setwd("/Users/mac/MyCode/R_WDI_DATA")
var_info <- import("VarInfo.xlsx")
info <- var_info |> head(10)
print(info)

```

````python

```
wdi <- import("WDI.rds")
wdi_10 <- wdi |> head(10)
wdi_10 <- wdi_10[,1:6]
print(wdi_10)
```

```
p <- ggplot(wdi_10,aes(year,AG.CON.FERT.ZS))+geom_line()
print(p)
```

```

```

```
