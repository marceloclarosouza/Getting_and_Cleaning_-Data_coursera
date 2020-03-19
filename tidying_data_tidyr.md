---
title: "Tidying data with tidyr"
author: "MarceloCS"
date: "09/03/2020"
output: pdf_document
---
# Tidy data satisfies three conditions:
1) Each variable forms a column
2) Each observation forms a row
3) Each type of observational unit forms a table


A tidy data is when each variable occupies exactly one column

```{r}
gather(students, sex, count, -grade)
```


Students2 suffers from the same messy data problem of having **column headers that are values** (male_1, female_1, etc.).
Tidying this dataset will be a two step process.
Call separate() on res to split the sex_class column into sex and class


```{r}
students2
res <- gather(students2, sex_class, count, -grade)
res
separate(data = res, col = sex_class, into= c("sex", "class"))
```


the operator %>% commands to the next instruction
```{r}
students2 %>%
  gather(sex_class, count, -grade) %>%
  separate(sex_class, c("sex", "class")) %>%
  print
```

A third symptom of messy data is when **variables are stored in both rows and columns**

```{r}
students3
students3 %>%
  gather(class, grade, class1:class5, na.rm = TRUE) %>%
  print
```

```{r}
students3 %>%
  gather(class, grade, class1:class5, na.rm = TRUE) %>%
  spread(test, grade) %>%
  print
```

readr is required for certain data manipulations, such as `parse_number()

```{r}
library(readr)
students3 %>%
  gather(class, grade, class1:class5, na.rm = TRUE) %>%
  spread(test, grade) %>%
  ### Call to mutate() goes here %>%
  mutate(class=parse_number(class))%>%
  print
```

The fourth messy data problem we'll look at occurs when **multiple observational units are stored in the same table**.
At first glance, there doesn't seem to be much of a problem with students4. All columns are variables and all rows are observations. However, notice that each id, name, and sex is repeated twice, which seems quite redundant. This is a hint that our data contains multiple observational units in a single table.

Our solution will be to break students4 into two separate tables -- one containing basic student information (id, name, and sex) and the other containing grades (id, class, midterm, final).

```{r}
students4
student_info <- students4 %>%
  select(id, name, sex) %>%
  ### Your code here %>%
  unique %>%
  print
```

```{r}
gradebook <- students4 %>%
  ### Your code here %>%
  select(id, class, midterm, final)%>%
  print
```


The fifth and final messy data scenario that we'll address is when a **single observational unit is stored in multiple tables**

The name of each dataset actually represents the value of a new variable that we will call 'status'. Before joining the two tables together, we'll add a new column to each containing this information so that it's not lost when we put everything together.

```{r}
passed <- passed %>% mutate(status = "passed")
failed <- failed %>% mutate(status = "failed")

bind_rows(passed, failed)# to join the tables passed and failed into a single table
```


Of course, we could arrange the rows however we wish at this point, but the important thing is that each row is an observation, each column is a variable, and the table contains a single observational unit. Thus, the data are tidy.

As we've done before, we'll build up a series of chained commands, using functions from both tidyr and dplyr

```{r}
sat %>%
  select(-contains("total"))%>%###)) %>%
  gather(part_sex, count, -score_range)%>%###, ###, -###) %>%
  ### <Your call to separate()> %>%
  separate(part_sex, c("part", "sex"))%>%
  print
```


```{r}
sat %>%
  select(-contains("total")) %>%
  gather(part_sex, count, -score_range) %>%
  separate(part_sex, c("part", "sex")) %>%
  ### <Your call to group_by()> %>%
  group_by(part, sex)%>%
  mutate(total = sum(count),
         prop = count/total
  ) %>% print
```

