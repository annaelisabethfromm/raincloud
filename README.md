# repetitive rainclouds


Short tutorial to create raincloud plots to visualize development over time (e.g. training gain at a cognitive task) You can use the example data set (example_rain.xlsx). The data set contains the variables: id, group and the dependent variable for two time points (DV_pre and DV_post). 

## How to create repetitive raincloud plots?

### First Step: Structure the data 
- load resp. install required R packages: 
- set the working directory
- read the data to your R enviornment

df1 <- read.xlsx("example_rain.xlsx"
                 ,sheet = "1", startRow = 1, colNames = TRUE, rowNames = FALSE, detectDates = FALSE,   skipEmptyRows = TRUE,   skipEmptyCols = TRUE,   rows = NULL,   cols = NULL,   sep.names = ".",   na.strings = "NA",   fillMergedCells = FALSE)


- create long format 
