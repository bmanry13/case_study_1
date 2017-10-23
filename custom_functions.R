#################################################################################'
# File name: custom_functions.R
# Author: Brychan Manry
# Creation Date: 10/21/2017
# Last Edited: 10/22/2017
# Description: This source file contains custom functions used mutiple times d   
#               throughout the analysis document
#################################################################################'
makeMap <- function(shpobj, valueVarName, main_title,scaleBreaks = seq(0, 50, by = 10)){
  #==========================================================================================#
  # Function Name: makeMap
  # Author: Brychan Manry
  # Creation Date: 10/21/2017
  # Last Edited: 10/22/2017
  # Description: This function creates state-level color maps from a SpatialPolygonsDataFrame
  #              the contains shapefile information for US states along with related
  #              state-level information. The function plots Alaska and Hawaii seperatly then
  #              scales them and adds them to the plot with the continental US
  #
  # Citation / Acknowledgements
  #     This code was adapted from a tmaps tutorial on GitHub created by user mtennekes, the
  #     author of the tmap ("thematic map") R package used to make the maps. The demos and examples
  #     in the tmap repository (https://github.com/mtennekes/tmap) were pivitol in the create of
  #     this function.
  #
  #
  # Required R libraries: rgdal, tmap, tmaptools, grid
  # Args: 
  #   shpobj:       SpatialPolygonsDataFrame object with US states and related state-level data
  #   valueVarName: character string containing the column name of the numeric variable to be
  #                 used for map coloring
  #   main_title:   character string that will be used for the main title of the plot
  #   scaleBreaks:  numeric vector of breaks to use for map color segmentation
  #
  # Output:
  #   There is no output object, the results are plotted in the a new graphic device
  #==========================================================================================#
  
  # Load Libraries
  library(rgdal)
  library(tmap)
  library(tmaptools)
  library(grid)
  
  # Seperate Alaska and Hawaii becasue they are plotted individually
  usa_cont <- subset(shpobj, !State %in% c("AK","HI"))
  usa_ak <- subset(shpobj, State == "AK")
  usa_hi <- subset(shpobj, State == "HI")
  
  # Create main plot with continental US
  map_cont <- tm_shape(usa_cont) +
    tm_polygons(valueVarName, title = "", showNA = TRUE,
                border.col = "gray50", border.alpha = .5,
                breaks = scaleBreaks) +
    tm_credits("Shape @ Unites States Census Bureau",
               position = c("right", "bottom")) +
    tm_layout(title = main_title, 
              title.position = c("center", "top"), 
              legend.position = c("right", "bottom"), 
              frame = FALSE, 
              inner.margins = c(0.1, 0.1, 0.15, 0.05))
  # Create Alaska Plot
  map_ak <- tm_shape(usa_ak, projection = 3338) +
    tm_polygons(valueVarName, title = "", showNA = TRUE,
                border.col = "gray50", border.alpha = .5,
                breaks = scaleBreaks) +
    tm_layout("Alaska", legend.show = FALSE, bg.color = NA, 
              title.size = 0.8, frame = FALSE, title.position = c("left","top"))
  # Create Hawaii Plot: used a limited bounding box which excludes several of the smaller easter islands
  # to conserve space
  map_hi <- tm_shape(usa_hi, bbox = matrix(c(-161, 18.9, -154.80677, 23), nrow = 2)) +
    tm_polygons(valueVarName, title = "", showNA = TRUE,
                border.col = "gray50", border.alpha = .5,
                breaks = scaleBreaks) +
    tm_layout("Hawaii", legend.show = FALSE, bg.color=NA, title.position = c("right", "top"), 
              title.size = 0.8, frame=FALSE)
  
  # Create viewports which will house the AK and HI plots and scale them to be added to main plot
  vp_ak <- viewport(x = 0.15, y = 0.15, width = 0.3, height = 0.3)
  vp_hi <- viewport(x = 0.35, y = 0.15, width = 0.3, height = 0.2)
  
  # Initiate tmap plot mode to capture main plot and add AK and HI
  tmap_mode("plot")
  print(map_cont)
  print(map_ak, vp = vp_ak)
  print(map_hi, vp = vp_hi)
}