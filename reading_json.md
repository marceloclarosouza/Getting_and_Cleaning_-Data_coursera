---
title: "JSON"
author: "MarceloCS"
date: "04/03/2020"
output: pdf_document
---
Javascript Object Notation

```{r}
library(jsonlite)
jsonData <-fromJSON("https:api.github.com/users/jtleek/repos")
names(jsonData)
names(jsonData$owner)#access the arry owner
jsonData$owner$login
```

# writing data frames to JSON

```{r}
myjson <- toJSON(iris, pretty = TRUE)
cat(myjson)
```

# convert back to JSON

```{r}
iris2 <- fromJSON(myjson)
head(iris2)
```
www.json.org
