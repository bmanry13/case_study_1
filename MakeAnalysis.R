#################################################################################'
# File name: MakeAnalysis.R
# Author: Brychan Manry
# Creation Date: 10/22/2017
# Last Edited: 10/22/2017
# Description: This file runs the source files, creates the analysis html document,
#               and then creates GitHub readme file
#################################################################################'

##### LOAD ALL LIBRARIES REQUIRED FOR ANALYSIS #####
library(dplyr)
library(kableExtra)
library(knitr)
library(ggplot2)
library(ggthemes)
library(tmap)
library(tmaptools)
library(grid)

##### INGEST DATA #####
source("./source/data_processing.R")

##### LOAD CUSTOM FUNCTIONS ####
source("./source/custom_functions.R")

##### Knit html and Markdown File ####
rmarkdown::render(input = "./analysis/Case Study 1 - US Breweries Analysis.Rmd", 
                  output_file = "Hotshot Hops - US Breweries Analysis.html",
                  output_options =  list(keep_md = TRUE, self_contained=TRUE,
                                         theme = "journal", toc = TRUE, toc_float = TRUE))
##### Knit README file for GitHub #####
knitr::knit(input = "README.Rmd", output = "README.md")
