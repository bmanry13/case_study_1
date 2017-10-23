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
## R version 3.4.1 (2017-06-30)
## Platform: x86_64-w64-mingw32/x64 (64-bit)
## Running under: Windows >= 8 x64 (build 9200)
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
##  [1] bindrcpp_0.2     rgdal_1.2-13     sp_1.2-5         readr_1.1.1     
##  [5] tmaptools_1.2-1  tmap_1.10        ggthemes_3.4.0   ggplot2_2.2.1   
##  [9] knitr_1.17       kableExtra_0.5.2 dplyr_0.7.2     
## 
## loaded via a namespace (and not attached):
##   [1] colorspace_1.3-2   deldir_0.1-14      class_7.3-14      
##   [4] gdalUtils_2.0.1.7  leaflet_1.1.0      rprojroot_1.2     
##   [7] satellite_1.0.0    base64enc_0.1-3    dichromat_2.0-0   
##  [10] rstudioapi_0.6     xml2_1.1.1         codetools_0.2-15  
##  [13] splines_3.4.1      R.methodsS3_1.7.1  geojsonlint_0.2.0 
##  [16] jsonlite_1.5       png_0.1-7          R.oo_1.21.0       
##  [19] rgeos_0.3-25       shiny_1.0.4        data.tree_0.7.3   
##  [22] DiagrammeR_0.9.2   compiler_3.4.1     httr_1.3.1        
##  [25] backports_1.1.0    mapview_2.1.4      assertthat_0.2.0  
##  [28] Matrix_1.2-10      lazyeval_0.2.0     visNetwork_2.0.1  
##  [31] htmltools_0.3.6    tools_3.4.1        igraph_1.1.2      
##  [34] coda_0.19-1        gtable_0.2.0       glue_1.1.1        
##  [37] reshape2_1.4.2     gmodels_2.16.2     V8_1.5            
##  [40] Rcpp_0.12.12       rgexf_0.15.3       raster_2.5-8      
##  [43] spdep_0.6-15       gdata_2.18.0       nlme_3.1-131      
##  [46] udunits2_0.13      iterators_1.0.8    crosstalk_1.0.0   
##  [49] stringr_1.2.0      rvest_0.3.2        mime_0.5          
##  [52] gtools_3.5.0       XML_3.98-1.9       LearnBayes_2.15   
##  [55] MASS_7.3-47        scales_0.5.0       hms_0.3           
##  [58] expm_0.999-2       RColorBrewer_1.1-2 yaml_2.1.14       
##  [61] curl_2.8.1         geosphere_1.5-5    gridExtra_2.2.1   
##  [64] downloader_0.4     pander_0.6.1       stringi_1.1.5     
##  [67] jsonvalidate_1.0.0 highr_0.6.1        Rook_1.1-1        
##  [70] foreach_1.4.3      e1071_1.6-8        boot_1.3-19       
##  [73] rlang_0.1.2        pkgconfig_2.0.1    bitops_1.0-6      
##  [76] evaluate_0.10.1    lattice_0.20-35    purrr_0.2.3       
##  [79] bindr_0.1          sf_0.5-4           labeling_0.3      
##  [82] htmlwidgets_0.9    osmar_1.1-7        plyr_1.8.4        
##  [85] magrittr_1.5       R6_2.2.2           DBI_0.7           
##  [88] units_0.4-6        RCurl_1.95-4.8     tibble_1.3.4      
##  [91] rmapshaper_0.3.0   KernSmooth_2.23-15 rmarkdown_1.6     
##  [94] viridis_0.4.0      influenceR_0.1.0   webshot_0.4.2     
##  [97] digest_0.6.12      classInt_0.1-24    xtable_1.8-2      
## [100] tidyr_0.7.0        httpuv_1.3.5       brew_1.0-6        
## [103] R.utils_2.5.0      stats4_3.4.1       munsell_0.4.3     
## [106] viridisLite_0.2.0
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
## 4   ¦--Hotshot Hops - US Breweries Analysis.html   
## 5   ¦--Hotshot Hops - US Breweries Analysis.md     
## 6   ¦--Hotshot Hops - US Breweries Analysis_files  
## 7   ¦   °--figure-html                             
## 8   ¦       ¦--q1map-1.png                         
## 9   ¦       ¦--q4-1.png                            
## 10  ¦       ¦--q4mapabv-1.png                      
## 11  ¦       ¦--q4mapibu-1.png                      
## 12  ¦       ¦--q5-1.png                            
## 13  ¦       ¦--q5-2.png                            
## 14  ¦       ¦--q6 part2-1.png                      
## 15  ¦       ¦--q6 part2-2.png                      
## 16  ¦       °--q7-1.png                            
## 17  ¦--MakeAnalysis.R                              
## 18  ¦--mapdata                                     
## 19  ¦   ¦--cb_2016_us_state_500k.cpg               
## 20  ¦   ¦--cb_2016_us_state_500k.dbf               
## 21  ¦   ¦--cb_2016_us_state_500k.prj               
## 22  ¦   ¦--cb_2016_us_state_500k.shp               
## 23  ¦   ¦--cb_2016_us_state_500k.shp.ea.iso.xml    
## 24  ¦   ¦--cb_2016_us_state_500k.shp.iso.xml       
## 25  ¦   ¦--cb_2016_us_state_500k.shp.xml           
## 26  ¦   ¦--cb_2016_us_state_500k.shx               
## 27  ¦   °--README.md                               
## 28  ¦--rawdata                                     
## 29  ¦   ¦--Beers.csv                               
## 30  ¦   ¦--Breweries.csv                           
## 31  ¦   °--Codebook.md                             
## 32  ¦--README.md                                   
## 33  ¦--README.Rmd                                  
## 34  °--source                                      
## 35      ¦--custom_functions.R                      
## 36      °--data_processing.R
```

