---
title: "Subsetting and Sorting"
author: "MarceloCS"
date: "13/03/2020"
output: pdf_document
---

# Subsetting

```{r}
set.seed(13435)
x <- data.frame("var1" = sample(1:5), "var2" = sample(6:10), "var3" = sample(11:15))
x <- x[sample(1:5),]; x$var2[c(1,3)] = NA
x
x[,1]
x[,"var1"]
x[1:2, "var2"]
```

# Logical ands and ors

```{r}
x[(x$var1 <= 3 & x$var3 > 11),]
x[(x$var1 <= 3 | x$var3 > 15),]
```

# dealing with missing values
```{r}
x[which(x$var2 > 8),] # returns no NA
```

# Sorting
```{r}
sort(x$var1)
sort(x$var1, decreasing = TRUE)
sort(x$var2, na.last = TRUE)
```

# Ordering
```{r}
x[order(x$var1),]
x[order(x$var1, x$var3),]
```

# ordering with *plyr*
```{r}
library(plyr)
arrange(x, var1)
arrange(x, desc(var1))
```

# Adding rows and columns
```{r}
x$var4 <- rnorm(5)
x
y <- cbind(x, rnorm(5))
y
```

