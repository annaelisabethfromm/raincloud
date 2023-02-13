# repetitive rainclouds


Short tutorial to create raincloud plots to visualize development over time (e.g. training gain at a cognitive task) You can use the example data set (example_rain.xlsx). The data set contains the variables: id, group and the dependent variable (% correct) for two time points (DV_pre and DV_post). 

literature suggestions: 

## How to create repetitive raincloud plots?

### First Step: Structure the data 
- load resp. install required R packages: 
- set the working directory
- read the data to your R enviornment
#### Create long format 
                  df1_long <-reshape(df1, 
                   varying = c("DV_pre", "DV_post"), 
                   v.names="DV_value", 
                   timevar="DV",
                   times=c("DV_pre", "DV_post"),
                   new.row.names = 1:10000, 
                   direction = "long") 
####
#### Create new variable for the time points (sessions)
                  df0 <- df1_long %>%
                  mutate(session = case_when(
                  grepl("pre", DV) ~ "1",
                  grepl("post", DV) ~ "2"
                  ))
####
#### Create arrays for each time point and each group (example for group A time point 1)
                 PreA <- df0[which(df0$group=="A"
                              & df0$session=="1"), ]
                  PreA <- PreA$DV_value

                  PostA <- df0[which(df0$group=="A"
                              & df0$session=="2"), ]
                 PostA <- PostA$DV_value
####
#### Create necessary rain cloud structure (see: XXXX)
                nA <-length(PreA)
                dA <-data.frame(y=c(PreA, PostA),
                        x=rep(c(1,2), each=nA),
                        id =factor(rep(1:nA,2)))
                set.seed(321)
                dA$xj <-jitter(dA$x,amount=.09)
                
                score_mean_PreA <- mean(PreA, na.rm=TRUE)
                score_mean_PostA <- mean(PostA, na.rm=TRUE)
                y <- c(score_mean_PreA, score_mean_PostA)
                x <- c(1,2)
                dfmA<- data.frame(y, x)
####


