---
title: "Reading XML files"
author: "MarceloCS"
date: "04/03/2020"
output: pdf_document
---
```{r}
library(XML)
fileURl <- "http://www.w3chools.com/xml/simple.xml"
doc <- xmlTreeParse(fileUrl, useInternal = TRUE)
rootNode <- xmlRoot(doc)
xmlName(rootNode)
names(rootNode)

rootNode[[1]]#acess the first Node
rootNode[[1]][[1]]#access the first parameter in the first node

```

# progamatically extract parts of the file

```{r}
xmlSApply(rootNode, xmlValue)

```

        http://www.stat.berkeley.edu/~statcur/Workshop2/Presentations/XML.pdf
        
Get the items on the menu and prices
```{r}
xpathSApply(rootNode, "//name", xmlValue)#reading all the tags with NAME
xpathSApply(rootNode, "//price", xmlValue)#reading the tags with price
```

extract contents by attributes of website
```{r}
fileUrl <- "http://espn.go.com/nfl/team/_?names/bal/baltimore-ravens"
doc <- htmlTreeParseIfileUrl, useInternal = TRUE
scores <- xpathSApply(doc, "//li[@class = 'score']", xmlValue)
teams <- xpathSApply(doc, "//li[@class = 'team-name']"), xmlValue)
scores
teams
```
























