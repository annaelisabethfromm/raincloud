# repetitive rainclouds


Short tutorial to create raincloud plots to visualize development over time (e.g. training gain at a cognitive task) You can use the example data set (example_rain.xlsx). The data set contains the variables: id, group and the dependent variable for two time points (DV_pre and DV_post). 

## How to create repetitive raincloud plots?

### First Step: Structure the data 
- load resp. install required R packages: 
- set the working directory
- read the data to your R enviornment
- create long format
#### Code for long format 
                  df1_long <-reshape(df1, 
                   varying = c("DV_pre", "DV_post"), 
                   v.names="DV_value", 
                   timevar="DV",
                   times=c("DV_pre", "DV_post"),
                   new.row.names = 1:10000, 
                   direction = "long") 
####
