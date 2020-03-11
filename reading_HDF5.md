---
title: "Reading from HDF5"
author: "MarceloCS"
date: "11/03/2020"
output: pdf_document
---
# HDF5 - Hierarchical data format

http://www.hdfgroup.org/

R HDF5 package

```{r}
source("http://bioconductor.org/biocLite.R")
biocLite("rhdf5")
```


Create the hdf5 file
```{r}
library(rhdf5)
create = h5createFile("example.h5")
create
```

create groups
```{r}
created = h5createGroup("example.h5","foo")
created = h5createGroup("example.h5", "baa")
created = h5createGroup("example.h5", "foo/foobaa")
h5ls("example.h5")
```

write to groups
```{r}
A = matrix(1:10, nr=5, nc=2)
h5write(A, "example.h5", "foo/A")
B = array(seq(0.1, 2.0, by = 0.1), dim = c(5,2,2))
attr(B, "scale") <- "liter"
h5write(B, "example.h5", "foo/foobaa/B")
h5ls("example.h5")
```

write a data set
```{r}
df = data.frame(1L:5L, seq(0,1, length.out=5),
                c("ab","cde","fghi","a","s"), stringAsFactors = FALSE)
h5write(df,"example.h5", "df")
h5ls("example.h5")
```

Reading data
```{r}
readA = h5read("example.h5","foo/A")
readB = h5read("example.h5", "foo/foobaa/B")
readdf = h5read("example.h5", "df")
readA
```

writing and reading chunks
```{r}
h5write(c(12,13,14),"example.h5", "foo/A", index = list(1:3,1))
h5read("example.h5", "foo/A")
```

Notes and further resources
*hdf5* can be used to optimize reading/writing from disc in R

