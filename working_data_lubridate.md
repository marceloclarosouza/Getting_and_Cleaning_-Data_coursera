---
title: "Working with date"
author: "MarceloCS"
date: "24/03/2020"
output: pdf_document
---
# Date
```{r}
d1 <- date()
d1
class(d1)
d2 <- Sys.Date()
d2
class(d2)

```

# Formatting dates
        %d day as number
        %a abbreviated weekday
        %A unabbreviated weekday
        %m month
        %b abbreviated month
        %B unabbreviated month
        %y 2 digit year
        %Y 4 digit year
        
```{r}
format(d2, "%a %b %d %y")
```

# Creating dates
```{r}
x <- c("1jan1960", "2jan1960", "31mar1960", "30jul1960"); z = as.Date(x, "%d%b%y")
z[1]-z[2]
as.numeric(z[1]-z[2])
```

# Converting to Julian
```{r}
weekdays(d2)
months(d2)
julian(d2)
```

# Lubridate package
```{r}
library(lubridate)
ymd("20140106")
mdy("08/04/2013")
dmy("03-04-2013")
```


# Dealing with times
```{r}
ymd_hms("2011-08-03 10:15:03")
ymd_hms("2011-08-03 10:15:03", tz = "Pacific/Auckland")
?Sys.timezone
```

# Some functions have slightly different syntax
```{r}
x <- dmy(c("1jan2013", "2jan2013", "31mar2013", "30jul2013"))
wday(x[1])
wday(x[1], label= TRUE)
```



Ultimately you want your dates and times as class "Date" or the classes "POSIXct", "POSIXit". For more information type ?POSIXlt





















