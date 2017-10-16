# Case Study 1 - US Breweries
Brychan Manry and Patricia Goresen  
October 23, 2017  



## Ingest Data

```r
beers <- read.csv("./rawdata/Beers.csv") %>% rename(Beer_Name = Name)
breweries <- read.csv("./rawdata/Breweries.csv") %>% rename(Brewery_Name = Name)
```


## Q1



## Q2

```r
beers <- merge(beers, breweries, by.x = "Brewery_id", by.y = "Brew_ID")
```

## Q3


## Q4

```r
# Median ABV and IBU by State Alpha
ggplot(
  bind_rows(
    beers %>% select(State, val = ABV) %>% mutate(var = "ABV"),
    beers %>% select(State, val = IBU) %>% mutate(var = "IBU")) %>%
    group_by(State, var) %>%
    summarise(med.val = median(val, na.rm = TRUE)),
  aes(x = State, fill = var, group = var)) +
  geom_bar(aes(y = med.val), stat = "identity", position = "dodge") +
  facet_grid(var ~ ., scales = "free_y")
```

```
## Warning: Removed 1 rows containing missing values (geom_bar).
```

![](Case_Study_1_-_US_Breweries_Analysis_files/figure-html/q4-1.png)<!-- -->

## Q5

```r
# Median ABV by state - ordered by median
plot.df <- beers %>% group_by(State) %>% summarise(median.abv = median(ABV, na.rm = TRUE))
plot.df$State <- factor(plot.df$State, levels = plot.df$State[order(plot.df$median.abv, decreasing = TRUE)])
ggplot(plot.df, aes(State, y = median.abv)) + geom_bar(stat = "identity")
```

![](Case_Study_1_-_US_Breweries_Analysis_files/figure-html/q5-1.png)<!-- -->

```r
# Median IBU by state - ordered by median
plot.df <- beers %>% group_by(State) %>% summarise(median.ibu = median(IBU, na.rm = TRUE))
plot.df$State <- factor(plot.df$State, levels = plot.df$State[order(plot.df$median.ibu, decreasing = TRUE)])
ggplot(plot.df, aes(State, y = median.ibu)) + geom_bar(stat = "identity")
```

```
## Warning: Removed 1 rows containing missing values (position_stack).
```

![](Case_Study_1_-_US_Breweries_Analysis_files/figure-html/q5-2.png)<!-- -->

## Q6


## Q7

```r
ggplot(beers, aes(IBU, ABV))+
  geom_point() +
  geom_smooth(method = "lm")
```

```
## Warning: Removed 1005 rows containing non-finite values (stat_smooth).
```

```
## Warning: Removed 1005 rows containing missing values (geom_point).
```

![](Case_Study_1_-_US_Breweries_Analysis_files/figure-html/q7-1.png)<!-- -->

```r
pander::pander(summary(lm(ABV ~ IBU, data = beers)))
```


-----------------------------------------------------------------
     &nbsp;        Estimate    Std. Error   t value    Pr(>|t|)  
----------------- ----------- ------------ --------- ------------
 **(Intercept)**    0.04493    0.0005177     86.79        0      

     **IBU**       0.0003508   1.036e-05     33.86    3.263e-184 
-----------------------------------------------------------------


--------------------------------------------------------------
 Observations   Residual Std. Error   $R^2$    Adjusted $R^2$ 
-------------- --------------------- -------- ----------------
     1405             0.01007         0.4497       0.4493     
--------------------------------------------------------------

Table: Fitting linear model: ABV ~ IBU










