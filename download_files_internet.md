---
title: "Getting And Cleaning Data"
author: "MarceloCS"
date: "04/03/2020"
output: pdf_document
---
# Downloading files

# get/set your working directory

```{r}
getwd()
setwd()
setwd("/User/jtleek/data/") ## for windows users use \\ instead of //
```

checking for anfd creating directories

```{r}
if (!file.exists("data")){##checking if the directory exists
        dir.create("data")#creating a new directory
}
```

Dowloading file 
Useful for reproducibility
imposrt parameters are *url, destfile, method*
useful for downloading tab-delimited, csv, and other files

Example
```{r}
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile = "./data/cameras.csv", method = "curl")
list.files("./data")
```
```{r}
dateDownloaded <- date()
dateDownloaded
```
If the url starts with *http* you can use download.file()
if the url starts with https on windows you may be ok, in Mac you may need to set *method = "curl"*
be sure to record when you downloaded
