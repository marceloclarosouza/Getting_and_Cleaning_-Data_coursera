---
title: "Reading Excel Files"
author: "MarceloCS"
date: "04/03/2020"
output: pdf_document
---



```{r}
if(!file.exists("data")){dir.create("data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.xlsx?accessType=DOWNLOAD&bom=true&format=true"
doanload.file(fileUrl, destfile = "./data/cameras.xlsx", method = "curl")
dateDoenloaded <- date()

library(xlsx)
cameraData <- read.xlsx("./data/cameras.xlsx", sheetIndex = 1, header = TRUE)
head(cameraData)

```

Reading specific rows and columns

```{r}
colIndex <- 2:3
rowIndex <- 1:4
cameraDataSubset <- read.xlsx(".data/cameras.xlsx", sheetIndex = 1,
                              colIndex=colIndex, rowIndex=rowIndex)
cameraDataSubset

```

