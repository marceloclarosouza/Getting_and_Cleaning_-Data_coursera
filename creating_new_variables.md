---
title: "Creating new variables"
author: "MarceloCS"
date: "17/03/2020"
output: pdf_document
---
```{r}
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl,destfile = "./data/restaurants.csv", method = "curl")
restData <- read.csv("./data/restaurants.csv")
```

# Creating sequences
```{r}
s1 <- seq(1, 10, by = 2); s1
s2 <- seq(1, 10, length = 3); s2
x <- c(1,2,8,25,100); seq(along = x)
```

# Subsetting variables
```{r}
restData$nearMe <- restData$neighborhood %in% c("Roland", "Homeland")## 5in% returns false and true for each variable
table(restData$nearMe)
```

# Creating binary variables

```{r}
restData$zipWrong <- ifelse(restData$zipCode < 0, TRUE, FALSE)
table(restData$zipWrong, restData$zipCode < 0)
```

# Creating categorical variables

```{r}
restData$zipGroups = cut(restData$zipCode, breaks = quantile(restData$zipCode))
table(restData$zipGroups)
table(restData$zipGroups, restData$zipCode)
```

# Easier cutting
```{r}
library(Hmisc)
restData$zipGroups = cut2(restData$zipCode, g= 4)
table(restData$zipGroups)
```

# Creating factor variables
```{r}
restData$zcf <- factor(restData$zipCode)
restData$zcf[1:10]
class(restData$zcf)
```

# Levels of factor variables
```{r}
yesno <- sample(c("yes", "no"), size = 10, replace = TRUE)
yesnofac <- factor(yesno, levels = c("yes", "no"))
relevel(yesnofac, ref = "yes")
as.numeric(yesnofac)
```

# cutting produced factor variables
```{r}
library(Hmisc)
restData$zipGroups <- cut2(restData$zipCode, g= 4)
table(restData$zipGroups)
```

# Using the mutate function
```{r}
library(Hmisc); library(plyr)
restData <- mutate(restData, zipGroups=cut2(zipCode, g= 4))
table(restData$zipGroups)
```

# Common transforms
abs(x) absolute value
sqrt(x) square root
ceiling(x) ceiling(3.765) is 4
floor(x) floor(3.456) is 3
round(x, digits = n)
signif(x, digits = n)
cos(x); sin(x); tg(x)
log(x) natural logarithm
log2(x), log10(x), etc...
exp(x)

A tutorial from the developer of *plyr*
http://plyr.had.co.nz/09-user/
















