---
title: "Reading from APIs"
author: "MarceloCS"
date: "12/03/2020"
output: pdf_document
---
Create a dev account in twitter

http://dev.twitter.com/apps
create a new application
select the application

# Accessing Twitte from R
```{r}
myapp <- oauth_app("twitter",
                   key = "yourConsumerKeyHere", secret = "yourConsumerSecreteHere")
sig <- sign_oauth1.0(myapp,
                     token = "yourTokenHere",
                     token_secret ="yourTokenSecretHere")
homeTL = GET("https://api.twitter.com/1.1/statuses/home_timeline.json",sig)

```

# Converting the json object
```{r}
json1 = content(homeTL)
json2 = jsonlite::fromJSON(toJSON(json1))
json2[1,1:4]

```

**Most modern APis use something like oauth**
**httr works well with facebook, google, twitter, github, etc**

