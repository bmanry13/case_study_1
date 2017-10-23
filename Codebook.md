# Codebook for Case Study 1- US Breweries

# Introduction
This codebook contains information about the raw datasets, how it was cleaned and merged, and the final, tidy dataset.

#Raw Data Sets:
* Beers.csv
* Breweries.csv
 
#Variables for Beers.csv:
* Name: Name of the beer
* Beer_ID: Unique identifier of the beer
* ABV: Alcohol by volume of the beer
* IBU: International Bitterness Units of the beer
* Brewery_ID: Brewery ID associated with the beer
* Style: Style of the beer
* Ounces: Ounces of the beer
 
# Variables for Breweries.csv:
* Brew_ID: Unique identifier of the brewery
* Name: Name of the brewery
* City: City where the brewery is located
* State: State where the brewery is located
 
# Packages used for cleaning up the datasets
library(dplyr)
library(readr)

#Steps for tidying data (Code is contained in "data_processing.R")
1. Read in Beer.csv and Breweries.csv  
2. Remove Duplicate Observations from datasets  
3. Remove unnecessary whitespace from values 
4. Remove Extra Info inside of () from Beer and Brewery Names 
5. Clean abbreviations and punctuations
6. Check for duplicates and Erroronius Breweries
7. Check for duplicates and Erroronius Beers
8. Merge datasets 
