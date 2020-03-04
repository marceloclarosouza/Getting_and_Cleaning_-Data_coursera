---
title: "Data Table"
author: "MarceloCS"
date: "04/03/2020"
output: pdf_document
---
# data.table is faster than data frame
```{r}
library(data.table)
DF = data.frame(x=rnorm(9), y=rep(c("a", "b", "c"),each = 3), z = rnorm(9))
head(DF, 3)

DT = data.table(x=rnorm(9), y=rep(c("a", "b", "c"), each = 3), z = rnorm(9))
head(DT, 3)

tables()
DT[2,]
DT[DT$y=="a"]
DT[c(2,3)]#returns a matrix 1:2 rows 1:3 cols

```

Calculating values for variables with expressions

```{r}
DT[,list(mean(x), sum(z))]
DT[,table(y)]
```

Example to add a new columm

```{r}
DT[,w:=z^2]
```

Special variable 
**.N** count the times of a variable appears

```{r}
set.seef(123);
DT <- data.table(x=sample(letters[1:3],1E5, TRUE))
Dt[, .N, by = x]
```

Keys

```{r}
DT <- data.table(x=rep(c("a", "b", "c"), each = 100), y = rnorm(300))
setkey(DT, x)
DT['a']#associate a to x 
```


Joins

```{r}
DT1 <- data.table(x=c('a', 'a', 'b', 'dt1'), y = 1:4)
DT2 <- data.table(x=c('a', 'b', 'dt2'), z=5:7)
setkey(DT1, x); setkey(DT2, x)
merge(DT1, DT2)
```

Fast reading

```{r}
big_df <- data.frame(x=rnorm(1E6), y=rnorm(1E6))
filr <- tempfile()
write.table(big_df, file = file, row.names = FALSE, col.names = TRUE, sep = "\t", quote = FALSE)
system.time(fread(file))#faster than read.table
system.time(read.table(file, header = TRUE, sep = "\t"))
```























