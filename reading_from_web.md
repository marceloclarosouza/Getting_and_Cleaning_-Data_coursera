---
title: "Reading from The Web"
author: "MarceloCS"
date: "12/03/2020"
output: pdf_document
---
# Webscraping
Extrtactting data from the HTML code of websites

# Getting data off webpages = readLines()

```{r}
con = url("https://scholar.google.com.br/citations?user=GDsSX2UAAAAJ&hl=pt-BR")
htmlCode = readLines(con)
close(con)#close the conection with url
htmlCode
```

# Parsing with XML
```{r}
library(XML)
url <- "https://scholar.google.com.br/citations?user=GDsSX2UAAAAJ&hl=pt-BR"
html <-htmlTreeParse(url, useInternalNOdes = T)
xpathSApply(html, "//title", xmlValue)
xpathSApply(html, "//td[@id='col-citedby']", xmlValue)
```

# GET from the httr package
```{r}
library(httr); html2 = GET(url)
content2 = content(html2, as="text")
parseHtml = htmlParse(content2, asText=TRUE)
xpathSApply(parseHtml, "//title", xmlValue)
```

# Accessing website with passwords
```{r}
pg1 = GET("http://httpbin.org/basic-auth/user/passwd")
pg1
pg2 = GET("http://httpbin.org/basic-auth/user/passwd",
         authenticate ("user", "passwd"))
pg2
names(pg2)
```

# Using handles
```{r}
google = handle("http://google.com")
pg1 = GET(handle=google, path="/")
pg2 = GET(handle = google, path="search")
```

