# Case Study 1 README

## Introduction 
This repository contains the project to Case Study 1- US Breweries Analysis. This project used R, Rmarkdown, Github and Git.

## Purpose 
The Company Hotshot Hops is expanding their brewery across the nation. This analysis was used to determine which states they would succeed in based on the ABV and IBU of their beer. 

## Instructions for reproducing output
 1. Clone this repository
 2. Download and install the libraries
 3. Load the packages
 4. Run "data_processing.R" to tidy data
 5. Perform analysis on tidy data using file "Case Study 1- US Breweries Analysis.Rmd"


## Contributors: 
Brychan Manry and Patricia Goresen

## Session Info

```
## R version 3.4.2 (2017-09-28)
## Platform: x86_64-w64-mingw32/x64 (64-bit)
## Running under: Windows 7 x64 (build 7601) Service Pack 1
## 
## Matrix products: default
## 
## locale:
## [1] LC_COLLATE=English_United States.1252 
## [2] LC_CTYPE=English_United States.1252   
## [3] LC_MONETARY=English_United States.1252
## [4] LC_NUMERIC=C                          
## [5] LC_TIME=English_United States.1252    
## 
## attached base packages:
## [1] grid      stats     graphics  grDevices utils     datasets  methods  
## [8] base     
## 
## other attached packages:
##  [1] bindrcpp_0.2     data.tree_0.7.3  pander_0.6.1     tmaptools_1.2-1 
##  [5] tmap_1.10        rgdal_1.2-13     sp_1.2-5         ggthemes_3.4.0  
##  [9] ggplot2_2.2.1    knitr_1.17       kableExtra_0.5.2 readr_1.1.1     
## [13] dplyr_0.7.4     
## 
## loaded via a namespace (and not attached):
##   [1] colorspace_1.3-2   deldir_0.1-14      class_7.3-14      
##   [4] gdalUtils_2.0.1.7  leaflet_1.1.0      rprojroot_1.2     
##   [7] satellite_1.0.1    base64enc_0.1-3    dichromat_2.0-0   
##  [10] rstudioapi_0.7     xml2_1.1.1         codetools_0.2-15  
##  [13] splines_3.4.2      R.methodsS3_1.7.1  geojsonlint_0.2.0 
##  [16] jsonlite_1.5       png_0.1-7          R.oo_1.21.0       
##  [19] rgeos_0.3-25       shiny_1.0.5        DiagrammeR_0.9.2  
##  [22] compiler_3.4.2     httr_1.3.1         backports_1.1.1   
##  [25] mapview_2.1.4      assertthat_0.2.0   Matrix_1.2-11     
##  [28] lazyeval_0.2.0     visNetwork_2.0.1   htmltools_0.3.6   
##  [31] tools_3.4.2        igraph_1.1.2       coda_0.19-1       
##  [34] gtable_0.2.0       glue_1.1.1         reshape2_1.4.2    
##  [37] gmodels_2.16.2     V8_1.5             Rcpp_0.12.13      
##  [40] rgexf_0.15.3       raster_2.5-8       spdep_0.6-15      
##  [43] gdata_2.18.0       nlme_3.1-131       udunits2_0.13     
##  [46] iterators_1.0.8    crosstalk_1.0.0    stringr_1.2.0     
##  [49] rvest_0.3.2        mime_0.5           gtools_3.5.0      
##  [52] XML_3.98-1.9       LearnBayes_2.15    MASS_7.3-47       
##  [55] scales_0.5.0       hms_0.3            expm_0.999-2      
##  [58] RColorBrewer_1.1-2 yaml_2.1.14        curl_3.0          
##  [61] gridExtra_2.3      geosphere_1.5-5    downloader_0.4    
##  [64] stringi_1.1.5      jsonvalidate_1.0.0 highr_0.6         
##  [67] Rook_1.1-1         foreach_1.4.3      e1071_1.6-8       
##  [70] boot_1.3-20        rlang_0.1.2        pkgconfig_2.0.1   
##  [73] bitops_1.0-6       evaluate_0.10.1    lattice_0.20-35   
##  [76] purrr_0.2.4        bindr_0.1          sf_0.5-4          
##  [79] labeling_0.3       htmlwidgets_0.9    osmar_1.1-7       
##  [82] plyr_1.8.4         magrittr_1.5       R6_2.2.2          
##  [85] DBI_0.7            units_0.4-6        RCurl_1.95-4.8    
##  [88] tibble_1.3.4       rmapshaper_0.3.0   KernSmooth_2.23-15
##  [91] rmarkdown_1.6      viridis_0.4.0      influenceR_0.1.0  
##  [94] digest_0.6.12      classInt_0.1-24    webshot_0.4.2     
##  [97] xtable_1.8-2       tidyr_0.7.2        httpuv_1.3.5      
## [100] brew_1.0-6         R.utils_2.5.0      stats4_3.4.2      
## [103] munsell_0.4.3      viridisLite_0.2.0
```

## File Structure

```r
data.tree::as.Node(data.frame(pathString = paste0("Root/",list.files(recursive = TRUE))))
```

```
##                                           levelName
## 1  Root                                            
## 2   ¦--analysis                                    
## 3   ¦   °--Case Study 1 - US Breweries Analysis.Rmd
## 4   ¦--case_study_1.Rproj                          
## 5   ¦--Hotshot Hops - US Breweries Analysis.html   
## 6   ¦--Hotshot Hops - US Breweries Analysis.md     
## 7   ¦--Hotshot Hops - US Breweries Analysis_files  
## 8   ¦   °--figure-html                             
## 9   ¦       ¦--q1map-1.png                         
## 10  ¦       ¦--q4-1.png                            
## 11  ¦       ¦--q4mapabv-1.png                      
## 12  ¦       ¦--q4mapibu-1.png                      
## 13  ¦       ¦--q5-1.png                            
## 14  ¦       ¦--q5-2.png                            
## 15  ¦       ¦--q6 part2-1.png                      
## 16  ¦       ¦--q6 part2-2.png                      
## 17  ¦       °--q7-1.png                            
## 18  ¦--MakeAnalysis.R                              
## 19  ¦--mapdata                                     
## 20  ¦   ¦--cb_2016_us_state_500k.cpg               
## 21  ¦   ¦--cb_2016_us_state_500k.dbf               
## 22  ¦   ¦--cb_2016_us_state_500k.prj               
## 23  ¦   ¦--cb_2016_us_state_500k.shp               
## 24  ¦   ¦--cb_2016_us_state_500k.shp.ea.iso.xml    
## 25  ¦   ¦--cb_2016_us_state_500k.shp.iso.xml       
## 26  ¦   ¦--cb_2016_us_state_500k.shp.xml           
## 27  ¦   ¦--cb_2016_us_state_500k.shx               
## 28  ¦   °--README.md                               
## 29  ¦--rawdata                                     
## 30  ¦   ¦--Beers.csv                               
## 31  ¦   ¦--Breweries.csv                           
## 32  ¦   °--Codebook.md                             
## 33  ¦--README.md                                   
## 34  ¦--README.Rmd                                  
## 35  °--source                                      
## 36      ¦--custom_functions.R                      
## 37      °--data_processing.R
```

