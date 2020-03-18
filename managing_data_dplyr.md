---
title: "Managing data frames with dplyr - basic tools"
author: "MarceloCS"
date: "18/03/2020"
output: pdf_document
---
```{r}
library(dplyr)
```

```{r}
getwd()
setwd("D:/R/Getting_and_Cleaning_-Data_coursera")
if(!file.exists("./data")){
        dir.create("./data")
}
fileURL <- "https://github.com/DataScienceSpecialization/courses/blob/master/03_GettingData/dplyr/chicago.rds?raw=true"
download.file(fileURL, destfile = "./data/chicago.rds", method = "curl", extra = '-L')
```


```{r}
options(width = 105)
chicago <- readRDS("./data/chicago.rds")
dim(chicago)
str(chicago)
names(chicago)
head(select(chicago, city:dptp))
head(select(chicago, -(city:dptp)))
```

```{r}
chic.f <- filter(chicago, pm25tmean2 >30)
head(chic.f, 10)
chic.f <- filter(chicago, pm25tmean2 > 30 & tmpd > 80)
head(chic.f, 10)
```

```{r}
chicago <- arrange(chicago, date)#ascending order
head(chicago)
chicago <- arrange(chicago, desc(date))
head(chicago)
```

```{r}
chicago <- rename(chicago, pm25 = pm25tmean2, dewpoint = dptp)
head(chicago)
```

create new variables
```{r}
chicago <- mutate(chicago, pm25detrend = pm25-mean(pm25, na.rm = TRUE))
head(select(chicago, pm25, pm25detrend))

chicago <- mutate(chicago, tempcat = factor(1*(tmpd>80), labels = c("cold", "hot")))
hotcold <- group_by(chicago, tempcat)
hotcold
summarise(hotcold, pm25 = mean(pm25), o3 = max(o3tmean2), no2 = median(no2tmean2))#with NA
summarise(hotcold, pm25 = mean(pm25, na.rm = TRUE), o3 = max(o3tmean2), no2 = median(no2tmean2))#removing NA


chicago <- mutate(chicago, year = as.POSIXlt(date)$year + 1900)
years <- group_by(chicago, year)
summarize(years, pm25 = mean(pm25, na.rm = TRUE), o3 = max(o3tmean2), no2 = median(no2tmean2))

##pipeline sequency using %>%
chicago %>% mutate(month = as.POSIXlt(date)$mon +1) %>% group_by(month) %>% summarize(pm25 = mean(pm25, na.rm = TRUE), o3 = max(o3tmean2), no2 = median(no2tmean2))
```


Once you learn the dplyr "grammar" there are a few additional benefits
        dplyr can work with other data frame "backends"
        data.table for large fast tables
        SQL interface for relational databases via the DBI package
        
