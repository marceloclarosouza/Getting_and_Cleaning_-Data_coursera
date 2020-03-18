---
title: "Reshaping Data"
author: "MarceloCS"
date: "18/03/2020"
output: pdf_document
---
# Reshaping
```{r}
library(reshape2)
head(mtcars)
```

# Melting data frames
```{r}
mtcars$carname <- rownames(mtcars)
carMelt <- melt(mtcars, id = c("carname", "gear", "cyl"), measure.vars = c("mpg", "hp"))
head(carMelt, n = 3)
tail(carMelt, n = 3)
```

# Casting data frames
```{r}
cylData <- dcast(carMelt, cyl ~ variable)
cylData
cyldata <- dcast(carMelt, cyl ~ variable, mean)
cylData
```

# Averaging values
```{r}
head(InsectSprays)
tapply(InsectSprays$count, InsectSprays$spray,sum)
```

#Another way - split
```{r}
spIns <- split(InsectSprays$count, InsectSprays$spray)
spIns
```

# Another way - apply
```{r}
sprCount <- lapply(spIns, sum)
sprCount
```

# Another way - combine
```{r}
unlist(sprCount)
sapply(spIns, sum)
```

# Another way - plyr package
```{r}
library(plyr)
ddply(InsectSprays,.(spray), summarize, sum = sum(count))
```

# Creating a new variable
```{r}
spraySums <- ddply(InsectSprays,.(spray), summarize, sum = ave(count, FUN = sum))
dim(spraySums)
head(spraySums)
```


tutorial from the developer of plyr http://plyr.had.co.nz/09-user
reshape tutorial http://slideshare.net/jeffreybreen/reshaping-data-in-r


extra functions

acast - for casting as multi-dimensional arrays
arrange - for faster reordering using order() commands
mutate - adding new variables
