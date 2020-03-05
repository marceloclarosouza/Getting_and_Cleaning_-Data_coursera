---
title: "Manipulating Data with dplyr"
author: "MarceloCS"
date: "05/03/2020"
output: pdf_document
---
```{r}
mydf <- read.csv(path2csv, stringsAsFactors = FALSE)
dim(mydf)
head(mydf)
library(dplyr)
cran <- tbl_df(mydf)
mr("mydf")# remove mydf data

```
# Select the columms

```{r}
select(cran, ip_id, package, country)
select(cran, r_arch:country)#select all columns starting from r_arch and ending with country
select(cran, -time)#omitting the time columm
select(cran, -(X:size))#remove the collums from X to size
```

# Filter a subset of rows

```{r}
filter(cran, package =="swirl") #select all the rows
filter(cran, r_version == "3.1.1", country == "US")
filter(cran, r_version <= "3.0.2", country == "IN")
filter(cran, size > 100500, r_os =="linux-gnu")
filter(cran, !is.na(r_version))

```

# Arrange thr order of the rows
```{r}
cran2 <- select(cran, size:ip_id)
arrange(cran2, ip_id)#ascending order < to >
arrange(cran2, desc(ip_id))#decending order > to <
arrange(cran2, package, ip_id)#arrange using two variable
arrange(cran2, country, desc(r_version), ip_id)
```

# Create a new variable based on the value of one or more variables already in a dataset

```{r}
cran3 <- select(cran, ip_id, package, size)
mutate(cran3, size_mb = size / 2^20)
mutate(cran3, size_mb = size /2^20, size_gb = size_mb / 2^10)
mutate(cran3, correct_size = size + 1000)#add 100 to size

 
```
# collapses the dataset to a single row

```{r}
summarize(cran, avg_bytes = mean(size))
```

