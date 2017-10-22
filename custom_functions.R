
makeMap <- function(shpobj, valueVarName, main_title,scaleBreaks = seq(0, 50, by = 10)){
  
  usa_cont <- subset(shpobj, !State %in% c("AK","HI"))
  usa_ak <- subset(shpobj, State == "AK")
  usa_hi <- subset(shpobj, State == "HI")
  
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
  
  map_ak <- tm_shape(usa_ak, projection = 3338) +
    tm_polygons(valueVarName, title = "", showNA = TRUE,
                border.col = "gray50", border.alpha = .5,
                breaks = scaleBreaks) +
    tm_layout("Alaska", legend.show = FALSE, bg.color = NA, title.size = 0.8, frame = FALSE, title.position = c("left","top"))
  map_hi <- tm_shape(usa_hi, bbox = matrix(c(-161, 18.9, -154.80677, 23), nrow = 2)) +
    tm_polygons(valueVarName, title = "", showNA = TRUE,
                border.col = "gray50", border.alpha = .5,
                breaks = scaleBreaks) +
    tm_layout("Hawaii", legend.show = FALSE, bg.color=NA, title.position = c("right", "top"), title.size = 0.8, frame=FALSE)
  
  
  vp_ak <- viewport(x = 0.15, y = 0.15, width = 0.3, height = 0.3)
  vp_hi <- viewport(x = 0.35, y = 0.15, width = 0.3, height = 0.2)
  
  
  tmap_mode("plot")
  print(map_cont)
  print(map_ak, vp = vp_ak)
  print(map_hi, vp = vp_hi)
}