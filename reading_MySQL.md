---
title: "Reading fom MySQL"
author: "MarceloCS"
date: "11/03/2020"
output: pdf_document
---
# Install MySQL on linux

terminal *shell> sudo apt-get install mysql-server*

#Installing RMySQL - LINUX (Ubuntu)

on terminal : *sudo apt-get install -y libmariadb-client-lgpl-dev*
on R:   *install.packages("BDI")*
        *install.packages("RMySQL")*        

check the status of the MySL server
*sudo service mysql status*

Stop the MySQL server
*sudo service mysql stop*

restart the MySQl server
*sudo service mysql start*

http://genome.ucsc.edu/goldenPath/help/mysql.html

# Connecting and listing databases

```{r}
ucscDb <- dbConnect(MySQL(), user = "genome", host = "genome-mysql.cse.ucsc.edu")
result <- dbGetQuery(ucscDb, "show databases;"); dbDisconnect(ucscDb);
result
```

# Connecting to hg19 and listing tables

```{r}
hg19 <- dbConnect(MySQL(), user = "genome", db = "hg19",
                  host = "genome-mysql.cse.ucsc.edu")
allTables <- dbListTables(hg19)
length(allTables)
allTables[1:5]
```

Get dimensions of a specific table
```{r}
dbListFields(hg19, "affyU133Plus2") #list the columns
dbGetQuery(hg19, "select count(*) from affyU133Plus2") # determine the n of rows
```

Read from the table
```{r}
affyData <- dbReadTable(hg19, "affyU133Plus2")
head(affyData)
```

Select a specific subset
```{r}
query <- dbSendQuery(hg19, "select * from affyU133Plus2 where misMatches between 1 and 3")
affyMis <- fetch(query); quantile(affyMis$misMatches)
affyMisSmall <- fetch(query, n=10); dbClearResult(query);
dim(affyMisSmall)
```

Don't forget to close the connection!!!
```{r}
dbDisconnect(hg19)
```

# Further resources
RMySQL vignette http://cran.r-project.org/web/packages/RMySQL/RMySQL.pdf
MySQL commands http://www.pantz.org/software/mysql/mysqlcommands.html
http://www.r-bloggers.com/mysql-and-r/

