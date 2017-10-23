# Analysis of US Brewery Market
Brychan Manry and Patricia Goresen  
October 23, 2017  
[Link to GitHub Repository](https://github.com/bmanry13/case_study_1)


```r
knitr::opts_chunk$set(echo = TRUE, message=FALSE)
```

# Introduction 
The Company Hotshot Hops is creating a plan to expand their brewery across the nation. This analysis used datasets "beer.csv" and "breweries.csv" to look at different factors that may help determine the success Hopshot Hops may have in each state. To help with their planning Hotshot Hops has requested the following:

1) How many breweries are present in each state?
2) Merge data and print first and last six observations
3) How many missing values are in each column?
4) Compare median alcohol content (ABV) and international bitterness unit (IBU) by state
5) Compare maximum ABV and IBU by state
6) A summary of for the ABV values
7) Test the apparent relationship between IBU and ABV?

# Data Processing and Cleaning
The raw "beer.csv" and "breweries.csv" data sets provided by Hotshot Hops, where processed using the 8 steps below. Additional information regarding the cleaning process can be found in the [codebook](https://github.com/bmanry13/case_study_1/blob/master/rawdata/Codebook.md) as well in the [data_processing.R](https://github.com/bmanry13/case_study_1/blob/master/source/data_processing.R) located on the GitHub repository.

1) Read in Beer.csv and Breweries.csv  
2) Remove Duplicate Observations from datasets  
3) Remove unnecessary whitespace from values 
4) Remove Extra Info inside of () from Beer and Brewery Names 
5) Clean abbreviations and punctuations
6) Check for duplicates and Erroronius Breweries
7) Check for duplicates and Erroronius Beers
8) Merge datasets 

*Map Shapefiles*: The map shapefiles were downloaded from the US States shapefiles data was acquired from the U.S. Census Bureau's MAF/TIGER geographic database can be accessed at https://www.census.gov/geo/maps-data/.

# Analysis
## Q1: How many breweries are present in each state?
#### **Reasoning:** More breweries means there will be more competition in that state.

To address this question we used the dplyr package to: group the breweries by State, and then summaries by state the number of beweries within. Those state-level counts were then joined to the map shapefile data and run through the makeMap custom function which creates the map plot below. The source for the makeMap function can be found in the [custom_functions.R](https://github.com/bmanry13/case_study_1/blob/master/source/custom_functions.R) source file in the analysis GitHub repository.


```r
usa.states.shape@data <- usa.states.shape@data %>%
  left_join(
    breweries %>% group_by(State) %>% summarise(n_breweries = n())
  )
```

```
## Warning: Column `State` joining factor and character vector, coercing into
## character vector
```

```r
makeMap(usa.states.shape,"n_breweries", "Number of Breweries by State")
```

![](HOTSHO~1/figure-html/q1map-1.png)<!-- -->
The number of breweries in each state are shown in the table. The top five are Colorado with 47, California with 39, Michigan with 32, Oregon with 29 and Texas with 28. A full table of state brewery counts can be found [at the bottom of this report](#countTable)

#### **Conclusion:** Since Colorado has the most breweries, Hotshot Hops might not want to expand there.

## Q2: Merge data and print first and last six observations
To merge the data, the breweries data frame was joined to the beers data frame using the merge() function. Then head and tail calls were piped to a kable() function to produce tables for the top and bottom 6 rows of the data.

```r
beers <- merge(beers, breweries, by.x = "Brewery_id", by.y = "Brew_ID")
head(beers, n=6) %>% kable(row.names = FALSE, caption = "First Six Rows of Merged Data")
```



Table: First Six Rows of Merged Data

 Brewery_id  Beer_Name        Beer_ID     ABV   IBU  Style                                  Ounces  Brewery_Name        City          State 
-----------  --------------  --------  ------  ----  ------------------------------------  -------  ------------------  ------------  ------
          1  Get Together        2692   0.045    50  American IPA                               16  NorthGate Brewing   Minneapolis   MN    
          1  Maggie's Leap       2691   0.049    26  Milk / Sweet Stout                         16  NorthGate Brewing   Minneapolis   MN    
          1  Wall's End          2690   0.048    19  English Brown Ale                          16  NorthGate Brewing   Minneapolis   MN    
          1  Pumpion             2689   0.060    38  Pumpkin Ale                                16  NorthGate Brewing   Minneapolis   MN    
          1  Stronghold          2688   0.060    25  American Porter                            16  NorthGate Brewing   Minneapolis   MN    
          1  Parapet ESB         2687   0.056    47  Extra Special / Strong Bitter (ESB)        16  NorthGate Brewing   Minneapolis   MN    

```r
tail(beers,n=6) %>% kable(row.names = FALSE, caption = "Last Six Rows of Merged Data")
```



Table: Last Six Rows of Merged Data

 Brewery_id  Beer_Name                    Beer_ID     ABV   IBU  Style                      Ounces  Brewery_Name                    City            State 
-----------  --------------------------  --------  ------  ----  ------------------------  -------  ------------------------------  --------------  ------
        556  Pilsner Ukiah                     98   0.055    NA  German Pilsener                12  Ukiah Brewing Company           Ukiah           CA    
        557  Heinnieweisse Weissebier          52   0.049    NA  Hefeweizen                     12  Butternuts Beer and Ale         Garrattsville   NY    
        557  Snapperhead IPA                   51   0.068    NA  American IPA                   12  Butternuts Beer and Ale         Garrattsville   NY    
        557  Moo Thunder Stout                 50   0.049    NA  Milk / Sweet Stout             12  Butternuts Beer and Ale         Garrattsville   NY    
        557  Porkslap Pale Ale                 49   0.043    NA  American Pale Ale (APA)        12  Butternuts Beer and Ale         Garrattsville   NY    
        558  Urban Wilderness Pale Ale         30   0.049    NA  English Pale Ale               12  Sleeping Lady Brewing Company   Anchorage       AK    

The merged data is in a data frame called beers. The first six beers are Get Together, Maggie's Leap, Wall's End, Pumpion, Stronghold, and Parapet ESB. The last six beers are Pilsner Ukiah, Heinnieweisse Weissebier, Snapperhead IPA, Moo Thunder Stout, Porkslap Pale Ale, and Urban Wilderness Pale Ale.

## Q3: Report the number of NA's in each column
The colSums() function in conjunction with the is.na() function was used to calculate the number of missing values for each column.


```r
colSums(is.na(beers))
```

```
##   Brewery_id    Beer_Name      Beer_ID          ABV          IBU 
##            0            0            0           62          973 
##        Style       Ounces Brewery_Name         City        State 
##            5            0            0            0            0
```
The ABV column has 62 NAs, the IBU column has 1005 NAs, and the other columns have 0 NAs.

## Q4: Compute the median alcohol content and international bitterness unit for each state. Plot a bar chart to compare
To address this question the median ABV and IBU values were appended together then the medians for each were calculated using dplyr summaries(). The plot was created using ggplot with a facet grid to separate the ABV and IBU plots but while maintaining x-axis alignment.


```r
# Median ABV and IBU by State Alpha
ggplot(
  bind_rows(
    beers %>% select(State, val = ABV) %>% mutate(var = "ABV"),
    beers %>% select(State, val = IBU) %>% mutate(var = "IBU")) %>%
    group_by(State, var) %>%
    summarise(med.val = median(val, na.rm = TRUE)),
  aes(x = State, fill = var, group = var)) +
  geom_bar(aes(y = med.val), stat = "identity",  position = "dodge", show.legend = FALSE) +
  facet_grid(var ~ ., scales = "free_y") +
  ylab("") +
  ggtitle("Median ABV and IBU, by State")
```

```
## Warning: Removed 1 rows containing missing values (geom_bar).
```

![](HOTSHO~1/figure-html/q4-1.png)<!-- -->

#### **ABV Reasoning:** A low median alcohol content could suggest there are strict state laws against brewing beers with higher alcohol content.  

Similar to Q1 above the dplyr package to: group the breweries by State, and then summaries the median values for ABV and IBU. Those state-level values were then joined to the map shapefile data and run through the makeMap custom function.


```r
usa.states.shape@data <- usa.states.shape@data %>%
  left_join(
    beers %>% group_by(State) %>% summarise(med_abv = median(ABV, na.rm = TRUE))
  )

makeMap(usa.states.shape, "med_abv", "Median ABV by State",seq(0.04,0.07,.005))
```

![](HOTSHO~1/figure-html/q4mapabv-1.png)<!-- -->

#### **Conclusion:** Since Hotshot Hops does not want to expand in a state with strict laws against higher alcohol contents, they should consider ruling out expansion into Utah and Massachusetts. Hotshot Hops should consider potential expansions in: District of Columbia, Kentucky, Michigan, New Mexico, and West Virginia.  

#### **IBU reasoning:** Hotshot Hops' beer has a relatively high international bitterness unit, â€œIBUâ€. As a result, we want to expand in a state that is use to drinking beers with higher IBUs.  


```r
usa.states.shape@data <- usa.states.shape@data %>%
  left_join(
    beers %>% group_by(State) %>% summarise(med_ibu = median(IBU, na.rm = TRUE))
  )
makeMap(usa.states.shape, "med_ibu", "Median IBU by State",seq(21,61,10))
```

![](HOTSHO~1/figure-html/q4mapibu-1.png)<!-- -->


#### **Conclusion:** Since Maine, West Virginia, Florida, Georgia, and Deleware have the highest median IBUs Hotshot Hops should consider expanding there. Hotshot Hops should rule out all states that are in the 21 to 31 range.

The states with the highest median ABV are the District of Columbia, Kentucky, Michigan, New Mexico, and West Virginia respectively. The states with the highest IBU are Maine, West Virginia, Florida, Georgia, and Deleware respectively.

## Q5: Which state has the maximum alcoholic beer? Which state has the most-bitter beer?

#### **Reasoning for State's median ABV and IBU:** Similar to above, the state with the highest ABV is very unlikely to implement strict ABV laws. The state with the largest median IBU would indicate beers similar to Hotshot Hops's product lineup are present.
Dplyr and summaries() were once again used to calculate max ABV and IBU by state. The results for each where then used to order the State variable factor levels so the ggplot bar plots would be ordered from highest to lowest.


```r
# Median ABV by state - ordered by median
plot.df <- beers %>% group_by(State) %>% summarise(max.abv = max(ABV, na.rm = TRUE))
plot.df$State <- factor(plot.df$State, levels = plot.df$State[order(plot.df$max.abv, decreasing = TRUE)]) # orde states
ggplot(plot.df, aes(State, y = max.abv)) + geom_bar(stat = "identity") +
  ylab("Max ABV")
```

![](HOTSHO~1/figure-html/q5-1.png)<!-- -->

```r
# Median IBU by state - ordered by median
plot.df <- beers %>% group_by(State) %>% summarise(max.ibu = max(IBU, na.rm = TRUE))
plot.df$State <- factor(plot.df$State, levels = plot.df$State[order(plot.df$max.ibu, decreasing = TRUE)])
ggplot(plot.df, aes(State, y = max.ibu)) + geom_bar(stat = "identity") +
  ylab("Max IBU")
```

```
## Warning: Removed 1 rows containing missing values (geom_bar).
```

![](HOTSHO~1/figure-html/q5-2.png)<!-- -->

#### **Conclusion for medians:** The states with the highest median ABV is the District of Columbia. The state with the largest IBU is Maine. Both of these States would be a match for Hotshot Hops' expansion.
To further assess the range of ABV and IBU values ggplot was used to plot individual points for each beer within each state.


```r
#Maximum ABV of all States
MaxABV <- beers[which.max(beers$ABV),]
ggplot(beers, aes(x=State, y=ABV)) + geom_point(col="gray38", size=2) +geom_point(data=MaxABV, col="red2", size=2.5) + geom_text(data=MaxABV, label="Max ABV", vjust=1.4) + geom_segment(aes(x=State, xend= State, y=min(ABV), yend=max(ABV)), linetype="dashed", size=0.1) + labs(title= "ABV values for Corresponding States") + theme(axis.text.x=element_text(angle=90, hjust=1))
```

```
## Warning: Removed 62 rows containing missing values (geom_point).
```

```
## Warning: Removed 2240 rows containing missing values (geom_segment).
```

![](HOTSHO~1/figure-html/q6 part2-1.png)<!-- -->

```r
#Maximum IBU of all States
MaxIBU <- beers[which.max(beers$IBU),]
ggplot(beers, aes(x=State, y=IBU)) + geom_point(col="gray38", size=2) +geom_point(data=MaxIBU, col="red2", size=2.5) + geom_text(data=MaxIBU, label="Max IBU", vjust=1.4) + geom_segment(aes(x=State, xend= State, y=min(IBU), yend=max(IBU)), linetype="dashed", size=0.1) + labs(title= "IBU values for Corresponding States") + theme(axis.text.x=element_text(angle=90, hjust=1))
```

```
## Warning: Removed 973 rows containing missing values (geom_point).

## Warning: Removed 2240 rows containing missing values (geom_segment).
```

![](HOTSHO~1/figure-html/q6 part2-2.png)<!-- -->

#### **Conclusion for Max:** The state that has the maximum ABV beer is Colorado. The state that has the most-bitter beer is Oregon. These would both be good candidates for expansion based on Hotshot Hops' criteria.

## Q6: Summary statistics for the ABV
A simple summary() call was used to calculate the summary stats for ABV.


```r
summary(beers$ABV)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
## 0.00100 0.05000 0.05600 0.05987 0.06800 0.12800      62
```
The mean for the ABV variable is 0.05987 and the median is 0.056. The first quartile is 0.05 and the third quartile is 0.068 and the values range from 0.001 to 0.128 with 62 NAs.

## Q7: Is there an apparent relationship between the bitterness of the beer and its alcoholic content?
To create the plot for this question ggplot was used to make a point plot then add a linear smoothing line. The actual linear model was created with the lm() function then the results were formatted for use in html with pander().


```r
ggplot(beers, aes(IBU, ABV))+
  geom_point() +
  geom_smooth(method = "lm")
```

```
## Warning: Removed 973 rows containing non-finite values (stat_smooth).
```

```
## Warning: Removed 973 rows containing missing values (geom_point).
```

![](HOTSHO~1/figure-html/q7-1.png)<!-- -->

```r
pander::pander(summary(lm(ABV ~ IBU, data = beers)))
```


-----------------------------------------------------------------
     &nbsp;        Estimate    Std. Error   t value    Pr(>|t|)  
----------------- ----------- ------------ --------- ------------
 **(Intercept)**    0.04495    0.0005521     81.43        0      

     **IBU**       0.0003546   1.109e-05     31.98    6.111e-165 
-----------------------------------------------------------------


-------------------------------------------------------------
 Observations   Residual Std. Error   $R^2$   Adjusted $R^2$ 
-------------- --------------------- ------- ----------------
     1267             0.01021         0.447       0.4466     
-------------------------------------------------------------

Table: Fitting linear model: ABV ~ IBU

The model explains 44.93% of the variation in the ABV is explained by the IBU. As a result, there is not a strong linear relationship between ABV and IBU.

# Conclusion  
Based on similar ABVs and IBUs between Hotshot Hops beer and the stateâ€™s median, the states where Hotshot Hops will be the most successful are Maine, West Virginia, Florida, Georgia, New Mexico, West Virginia and Deleware.

# Appendix
## State Count Table {#countTable}
This table was created by transforming the results of a table() call on the "State" column of the breweries data frame, then piping those results to the kable() function to make an html table.

```r
as.data.frame(table(breweries$State), responseName = "Number of Breweries") %>% rename(State = Var1) %>% kable()
```



State    Number.of.Breweries
------  --------------------
AK                         7
AL                         3
AR                         2
AZ                        11
CA                        39
CO                        47
CT                         8
DC                         1
DE                         2
FL                        15
GA                         7
HI                         4
IA                         5
ID                         5
IL                        18
IN                        22
KS                         3
KY                         4
LA                         5
MA                        22
MD                         7
ME                         9
MI                        32
MN                        11
MO                         9
MS                         2
MT                         9
NC                        19
ND                         1
NE                         5
NH                         3
NJ                         3
NM                         4
NV                         2
NY                        16
OH                        15
OK                         6
OR                        29
PA                        25
RI                         5
SC                         4
SD                         1
TN                         3
TX                        28
UT                         4
VA                        15
VT                         9
WA                        23
WI                        19
WV                         1
WY                         4








