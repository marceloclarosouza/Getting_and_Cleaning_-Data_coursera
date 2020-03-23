---
title: "Merging data"
author: "MarceloCS"
date: "18/03/2020"
output: pdf_document
---
# Peer review data
```{r}
if (!file.exists("./data")){dir.create("./data")}
fileUrl1 <- "https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"
fileUrl2 <- "https://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv"
download.file(fileUrl1, destfile = "./data/reviews.csv", method = "curl")
download.file(fileUrl2, destfile = "./data/solutions.csv", method = "curl")
reviews <- read.csv2("./data/reviews.csv")
solutions <- read.csv2("./data/solutions.csv")
head(reviews, 2)
head(solutions, 2)

```
# Merging data - merge()
```{r}
names(reviews)
names(solutions)
mergedData <- merge(reviews, solutions, by.x = "solution_id", by.y = "id", all = TRUE)## missing values will be filled with NA
head(mergedData)

```

# Default - merge all common column names
```{r}
intersect(names(solutions),names(reviews))
mergeddata2 <- merge(reviews, solutions, all = TRUE)
head(mergedData2)

```


# Using join in the plyr package
```{r}
library(plyr)
df1 <- data.frame(id = sample(1:10), x=rnorm(10))
df2 <- data.frame(id = sample(1:10), y=rnorm(10))
arrange(join(df1, df2), id)
```

If you have multiple data frames
```{r}
df1 <- data.frame(id = sample(1:10), x = rnorm(10))
df2 <- data.frame(id = sample(1:10), y = rnorm(10))
df3 <- data.frame(id = sample(1:10), z = rnorm(10))
dfList <- list(df1, df2, df3)
join_all(dfList)
```

types of joins ; http://en.wikipedia.org/wiki/Join_(SQL)

