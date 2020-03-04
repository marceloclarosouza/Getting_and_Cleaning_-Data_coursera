---
title: "reading local files"
author: "MarceloCS"
date: "04/03/2020"
output: pdf_document
---
```{r}
#example
cameraData <- read.table("./data/cameras.csv", sep = ",", header = TRUE)
head(cameraData)

## using read.csv sets sep = ",", and header = TRUE
cameraData <- read.csv("./data/cameras.csv")
head(cameraData)
```

*quote = ""* mean no quote, since one of the biggest trouble with reading flat files are quotation marks ' or "
*na.string* SET THE CHARACTER THAT REPRESENTS A MISSING VALUE
*nrows* e.g. nrows = 10
*skip* number of lines to skipe before to read

