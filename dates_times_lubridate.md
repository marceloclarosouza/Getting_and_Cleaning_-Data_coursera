---
title: "Dates and Times with lubridate"
author: "MarceloCS"
date: "10/03/2020"
output: pdf_document
---
```{r}
# library(lubridate)

this_day <- today()
year(this_day)
month(this_day)
day(this_day)
wday(this_day)#day of the week
wday(this_day, label = TRUE)
this_moment <- now()#returns the date-time representing this exact moment in time
hour(this_moment)
minute(this_moment)
second(this_moment)
my_date <- ymd("1989-05-17")#add a time zone to the date
class(my_date)
mdy("March 12, 1975")
dmy(25081985)
ymd("1920/1/2")
dt1
ymd_hms(dt1)
hms("03:22:14")
```

lubridate is also capable of handling vectors of dates
The update() function allows us to update one or more components of a date-time

```{r}
dt2
ymd(dt2)
update(this_moment, hours = 8, minutes = 34, seconds = 55)
this_moment <- update(this_moment, hours= 10, minutes = 16, seconds = 0)
```

Now, pretend you are in New York City and you are planning to visit a friend in Hong Kong. You seem to have misplaced your itinerary, but you know that your flight departs New York at 17:34 (5:34pm) the day after tomorrow. You also know that your flight is scheduled to arrive in Hong Kong exactly 15 hours and 50 minutes after departure.

```{r}
nyc <- now("America/New_York")
nyc
depart <- nyc + days(2)
depart <- update(depart, hours = 17, minutes = 34)
arrive <- depart + hours(15) + minutes(50)#Ny time that you'll arrive in hong kong
arrive <- with_tz(arrive, "Asia/Hong_Kong")##Arrive in Hong_Kong time
arrive
last_time <- mdy("June 17, 2008", tz = "Singapore")#last time you see your friend in singapore
how_long <- interval(last_time, arrive)
as.period(how_long)
```

things like leap years, leap seconds, and daylight savings time, the length of any given minute, day, month, week, or year is relative to when it occurs. In contrast, the length of a second is always the same, regardless of when it occurs.
To address these complexities, the authors of lubridate introduce four classes of time related objects: instants, intervals, durations, and periods. These topics are beyond the scope of this lesson, but you can find a complete discussion in the 2011 Journal of Statistical Software paper titled 'Dates and Times Made Easy with lubridate'.

