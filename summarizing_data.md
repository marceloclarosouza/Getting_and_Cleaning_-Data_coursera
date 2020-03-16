---
title: "summarizing data"
author: "MarceloCS"
date: "16/03/2020"
output: pdf_document
---

# Getting the data from the web

```{r}
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl,destfile = "./data/restaurants.csv", method = "curl")
restData <- read.csv("./data/restaurants.csv")
head(restData, n=3)
tail(restData, n=3)
summary(restData)
str(restData)

```


# quantiles of quantitative variables
```{r}
quantile(restData$councilDistrict,na.rm = TRUE)
quantile(restData$conclilDistrict, probs = c(0.5,0.75,0.9))
```

# make table
```{r}
table(restData$zipCode, useNA = "ifany")# ifanay include NA on missing values
table(restData$councilDistrict, restData$zipCode)# two dimenstional table concil x zipcode
```


# check for missing values
```{r}
sum(is.na(restData$concilDistrict))
any(is.na(restData$concilDistrict))
all(restData$zipcode>0)
```

# row and columm sums
```{r}
colSums(is.na(restData))
all(colSums(is.na(restData))==0)
```

#values with specific characteristics
```{r}
table(restData$zipCode %in% c("21212")) # %in% similar to ==
table(restData$zipCode %in% c("21212", "21213"))
restData[restData$zipCode %in% c("21212", "21213"),]
```

# Cross tabs
```{r}
data(UCBAdmissions)
DF = as.data.frame(UCBAdmissions)
summary(DF)

xt <- xtabs(Freq ~ Gender +Admit, data = DF)
xt
```


#Flat tables
```{r}
warpbreaks$replicate <- rep(1:9, len = 54)
xt <- xtabs(breaks ~.,data=warpbreaks)
xt
ftable(xt)
```

#Size of a data set
```{r}
fakeData = rnorm(1e5)
object.size(fakeData)
print(object.size(fakeData), units = "Mb")
```

