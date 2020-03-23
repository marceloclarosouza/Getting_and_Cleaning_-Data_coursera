---
title: "Editing Text Variables"
author: "MarceloCS"
date: "23/03/2020"
output: pdf_document
---
# Fixing character vectors - tolower(), toupper()
```{r}
library(dplyr)
if(!file.exists("./data")) {dir.create("./data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile = "./data/cameras.csv", method = "curl")
cameraData <- read.csv("./data/cameras.csv")
names(cameraData)
tolower(names(cameraData))## make all names lower cases

```

# Fixing character vectors - strsplit()
        good for automatically splitting variables names
        Important parameters: *x, split*
```{r}
splitNames = strsplit(names(cameraData), "\\.")## "\\," it is to split the "." from the word
splitNames[[5]]
splitNames[[6]]
```

# Quick aside - list
```{r}
mylist <- list(letters = c("a", "b","c"), numbers = 1:3, matrix(1:25, ncol = 5))
head(mylist)
mylist[1]
mylist$letters
mylist[[1]]

```

# Fixing character vectors - sapply()
        Applies a function to each element in a vector or list
        important parameters: *X, FUN*
        Split the composed names and select only the firts name of the variable
        
```{r}
splitNames[[6]][[1]]

firstElement <- function(x){x[1]}
sapply(splitNames, firstElement)
```

#Peer review data
```{r}
fileUrl1 <- "https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"
fileUrl2 <- "https://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv"
download.file(fileUrl1, destfile = "./data/reviews.csv", method = "curl")
download.file(fileUrl2, destfile = "./data/solutions.csv", method = "curl")
reviews <- read.csv("./data/reviews.csv"); solutions <- read.csv("./data.solutions.csv")
head(reviews, 2)
head(solutions, 2)
```

# Fixing character vectors - sub()
        Important parameters, *pattern, replacement, x*
e.g subtitute "_" for ""(nothing) a list name file_id -> fileid
```{r}
names(reviews)
sub("_", "", names(reviews),)
```

# Fixing character vectors - gsub()
```{r}
testName <- "this_is_a_test"
sub("_", "",testName)#remove just the first _
gsub("_", "", testName) ##remoove multiple _

```

# Finding values - grep(), grepl()
```{r}
grep("Alameda", cameraData$intersection)
table(grepl("Alameda", cameraData$intersection))
cameraData2 <- cameraData[!grepl("Alameda", cameraData$intersection),]
```

# More on grep()
using value = TRUE returns where "alameda" is
```{r}
grep("Alameda", cameraData$intersection, value = TRUE)
grep("JeffStreet", cameraData$intersection)
length(grep("JeffStreet", cameraData$intersection))
```

# More useful string functions
```{r}
library(stringr)
nchar("Jeffrey Leek")
substr("Jeffrey Leek", 1,7)
paste("Jeffrey", "Leek")#paste two strings together
paste0("Jeffrey", "leek")#print two names without space
str_trim("Jeff      ")#remove the spaces at the end of the name

```

# Importante points about text in data sets
**Names of variables shoud be**
        all lower case when possible
        descriptive (diagnosis versus Dx)
        not duplicate
        not have underscores or dots ro while spaces
**Variables with character values**
        should usually be made into factor variables (depends on application)
        should be descriptive (use TRUE/FALSE instead 0/1, and Male/Female versus 0/1 or M/F)
        