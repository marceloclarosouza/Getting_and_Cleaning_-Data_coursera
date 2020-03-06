---
title: "Grouping and Chaining with dplyr"
author: "MarceloCS"
date: "06/03/2020"
output: pdf_document
---
```{r}
cran <- tbl_df(cran)#creating a table filr
rm("mydf")#remove the the original mydf
by_package <- group_by(cran, package)#grouping by package variable
summarize(by_package, mean(size)) ##returns the mean size for EACH package in our dataset
```

The 'count' column, created with n(), contains the total number of rows (i.e. downloads) for each package. The 'unique' column, created with n_distinct(ip_id), gives the total number of unique downloads for each package, as measured by the number of distinct ip_id's. The 'countries' column, created with n_distinct(country), provides the number of countries in which each package was downloaded. And finally, the 'avg_bytes' column, created with mean(size), contains the mean download size (in bytes) for each package.


```{r}
pack_sum <- summarize(by_package,
                      count = n() ,
                      unique = n_distinct(ip_id) ,
                      countries = n_distinct(country) ,
                      avg_bytes = mean(size))
```

We need to know the value of 'count' that splits the data into the top 1% and bottom 99% of packages based on total downloads

```{r}
quantile(pack_sum$count, probs = 0.99)
top_counts <- filter(pack_sum, count > 679)#filtering counts > 679
View(top_counts)

```

sort the rows 

```{r}
top_counts_sorted <- arrange(top_counts, desc(count))
View(top_counts_sorted)
```


```{r}
quantile(pack_sum,$unique, probs = 0.99)
top_unique <- filter(pack_sum, unique > 465)
View(top_unique)
top_unique_sorted <- arrange(top_unique, desc(unique))
View(top_unique_sorted)

```

# chaining / piping methods
 Chaining allows you to string together multiple function calls in a way that is compact and readable, while still accomplishing the desired result
 
```{r}
result2 <-
  arrange(
    filter(
      summarize(
        group_by(cran,
                 package
        ),
        count = n(),
        unique = n_distinct(ip_id),
        countries = n_distinct(country),
        avg_bytes = mean(size)
      ),
      countries > 60
    ),
    desc(countries),
    avg_bytes
  )

print(result2)

```

The benefit of %>% is that it allows us to chain the function calls in a linear fashion
```{r}
result3 <-
  cran %>%
  group_by(package) %>%
  summarize(count = n(),
            unique = n_distinct(ip_id),
            countries = n_distinct(country),
            avg_bytes = mean(size)
  ) %>%
  filter(countries > 60) %>%
  arrange(desc(countries), avg_bytes)

# Print result to console
print(result3)
View(result3)
```


select the columms
```{r}
cran %>%
  select(ip_id, country, package, size) %>%
  	print()
```



add a columm size_mb
```{r}
cran %>%
  select(ip_id, country, package, size) %>%
  mutate(size_mb = size / 2^20)
```

filtering size_mb > 0.5
```{r}
cran %>%
  select(ip_id, country, package, size) %>%
  mutate(size_mb = size / 2^20) %>%
  filter(size_mb <= 0.5) %>%
```

arrange in descending order
```{r}
cran %>%
  select(ip_id, country, package, size) %>%
  mutate(size_mb = size / 2^20) %>%
  filter(size_mb <= 0.5) %>%
  arrange(desc(size_mb))
```

