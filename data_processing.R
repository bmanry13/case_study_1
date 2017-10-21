#################################################################################'
# File name: data_processing.R
# Author: Brychan Manry
# Creation Date: 10/19/2017
# Last Edited: 10/19/2017
# Description: This source file reads in raw csv files provided for analysis and 
#               processes the data. It also reads in map shapefile information 
#               from the US Census Bureau TIGER repository
#
# R libraries: dplyr, readr
# input files: Beers.csv, Breweries.csv, /cb_2016_us_state_500k (shapefile folder)
#
# Output:
#   1) beers -> data.frame, each row is an individual beer
#   2) breweries -> data.fream, each row is an individual brewery
#   3) usa.states.shape -> SpatialPolygonsDataFrame, shapefile object for maps 
#                           using rdgal library
#################################################################################'

##### 1) READ IN RAW CSV FILES PROVIDED FOR ANALYSIS #####
# NOTE: set encoding to "UTF8" deal with issues handling special characters (e.g, è)
#==== READ Beers.csv ====
beers <- unique(readr::read_csv("./rawdata/Beers.csv",locale = readr::locale(encoding = "UTF8")) %>% rename(Beer_Name = Name)) 
str(beers)
#==== READ Breweries.csv ====
# Load Breweries Data
breweries <- unique(readr::read_csv("./rawdata/breweries.csv",locale = readr::locale(encoding = "UTF8")) %>% rename(Brewery_Name = Name)) 
str(breweries)

##### 2) REMOVE EXACT DUPLICATE RECORDS FROM BEERS AND BREWERIES #####
# NOTE: DEDUPLICATED IGNORING ID FIELDS
dedupDF <- function(){
  beers <<- beers[!duplicated(beers[-2]), ]
  breweries <<- breweries[!duplicated(breweries[-1]), ]
}
dedupDF()

##### 3) CLEAN LEADING/TRAILING WHITESPACE PRESENT IN SOME CHARACTER VALUES #####
#-- Function for remove leading/trailing white space from factor/character values
removeLeadTrailWS <- function(df){
  targetColumns <- names(df)[sapply(df, class)%in%c("factor", "character")] 
  df[targetColumns] <- lapply(df[targetColumns], function(x) gsub("^\\s|\\s$","",as.character(x)))
  return(df)
}
beers <- removeLeadTrailWS(beers)
breweries <- removeLeadTrailWS(breweries)
#==== DEDUPLICATE AFTER UPDATES ====
dedupDF()

##### 4) REMOVE EXTRA INFO FROM BEER AND BREWERY NAMES INSIDE OF () #####
beers$Beer_Name <- gsub(" \\(.*\\)","",beers$Beer_Name)
breweries$Brewery_Name <- gsub(" \\(.*$","",breweries$Brewery_Name)
#==== DEDUPLICATE AFTER UPDATES ====
dedupDF()

##### 5) CLEAN Abbreviations and related punctuation #####
print(breweries[grepl("^Saint |^Mount |^[a-zA-Z]{2}[^a-zA-Z]", breweries$City),])
#---- ^Mount to Mt ----
breweries$City <- gsub("^Mount ","Mt. ",breweries$City)
#---- ^Saint to St ----
breweries$City <- gsub("^Saint ","St. ",breweries$City)
#---- add period where missing for abbreviations ----
breweries$City <- gsub("(?<=^[a-zA-Z]{2}) ","\\. ", breweries$City, perl = TRUE)

#==== DEDUPLICATE AFTER UPDATES ====
dedupDF()

##### 6) CHECK FOR DUPLICATE/ERRORONIOUS BREWERIES #####
#==== SOME BREWERY NAMES ARE DUPLICATED ENSURE THEY ARE NOT ERRORS ====
print(breweries[breweries$Brewery_Name %in% names(table(breweries$Brewery_Name)[table(breweries$Brewery_Name)>1]),] %>%
    arrange(Brewery_Name))

#---- FIX: Blackrocks Brewery ----
# note: there is no Blackrocks Brewery in MA remove bewery ID #96 and change related beers to 13
breweries <- breweries[breweries$Brew_ID != 96, ]
beers$Brewery_id[beers$Brewery_id == 96] <- 13

#---- FIX: Blue Mountain Brewery ----
# note: there is no Blue Mountain Brewery in Arrington VA remove bewery ID #415 and change related beers to 383
breweries <- breweries[breweries$Brew_ID != 415, ]
beers$Brewery_id[beers$Brewery_id == 415] <- 383

#---- FIX: Lucette Brewing Company ----
# note: there is no such place as in Menominee WI remove bewery ID #378 and change related beers to 457
breweries <- breweries[breweries$Brew_ID != 378, ]
beers$Brewery_id[beers$Brewery_id == 378] <- 457

#---- OK: Oskar Blues Lucette Brewing Company ----
# note: These seem to be different locations of the same brewery so should be ok

#---- FIX: Otter Creek Brewing ----
# note: there is no Otter Creek Brewing in Waterbury VT remove bewery ID #262 and change related beers to 276
breweries <- breweries[breweries$Brew_ID != 262, ]
beers$Brewery_id[beers$Brewery_id == 262] <- 276

#---- OK: Sly Fox Brewing Company ----
# note: These seem to be different locations of the same brewery so should be ok

#---- FIX: Summit Brewing Company ----
# note: Duplicated remove bewery ID #139 and change related beers to 59
breweries <- breweries[breweries$Brew_ID != 139, ]
beers$Brewery_id[beers$Brewery_id == 139] <- 59

#==== DEDUPLICATE AFTER UPDATES ====
dedupDF()

##### 7) CHECK FOR DUPLICATE/ERRORONIOUS BEERS #####
beerIDTable <- table(paste(beers$Beer_Name, beers$Ounces, beers$Brewery_id, beers$Style, sep = "-"))
print(beerIDTable[beerIDTable > 1])
#==== AVERAGE ABV and IBU FOR SAME BEERS WITH MULTIPLE RECORDS ====
# Some beers are the same but with slight differences in ABV or IBU
# grouping by all other characteristics should except ID will allow for
# averages acorss same beers with slight differences
beers <- beers %>%
  group_by(Beer_Name, Brewery_id, Ounces, Style) %>%
  mutate(ABV = mean(ABV, na.rm = TRUE),
         IBU = mean(IBU, na.rm = TRUE))
beers$ABV[is.nan(beers$ABV)] <- NA
beers$IBU[is.nan(beers$IBU)] <- NA
dedupDF() 

##### 8) Cleanup #####
rm(list = ls()[!ls()%in%c("beers", "breweries")])


usa.states.shape <- rgdal::readOGR("mapdata","cb_2016_us_state_500k")
usa.states.shape@data <- usa.states.shape@data %>% 
  rename(State = STUSPS) %>%
  filter(State%in%breweries$State)

