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
### Second Step: Visualize the data
- create a ggplot 
#### Create data points of all participants
               ggplot(NULL, aes(y=y))+
                    geom_point(data=dA %>% filter(x=="1"), aes(x=xj), color="orange", size=6.0, alpha=.6)+
                    geom_point(data=dA %>% filter(x=="2"), aes(x=xj), color="red", size=6.0, alpha=.6)+
                    geom_point(data=dB %>% filter(x=="3"), aes(x=xj), color="skyblue2", size=6.0, alpha=.6)+
                    geom_point(data=dB %>% filter(x=="4"), aes(x=xj), color="dodgerblue", size=6.0, alpha=.6)
####
![grafik](https://user-images.githubusercontent.com/125254113/218565789-bf2b658f-346c-4a09-b430-60831287b21a.png)

#### add mean for each group and each time point
                    geom_point(data=dfmA %>% filter(x=="1"), aes(x=x), color="black", size=8, shape=18)+
                    geom_point(data=dfmA %>% filter(x=="2"), aes(x=x), color="black", size=8, shape=18)+
                    geom_point(data=dfmB %>% filter(x=="3"), aes(x=x), color="black", size=8, shape=18)+
                    geom_point(data=dfmB %>% filter(x=="4"), aes(x=x), color="black", size=8, shape=18)
####
![grafik](https://user-images.githubusercontent.com/125254113/218565905-95c2ac28-409d-4d2c-9cd4-2b0f53fa65da.png)

#### connect mean for each group and each time point
                    geom_segment(aes(x = 1, y = score_mean_PreA, xend = 2, yend = score_mean_PostA), color= "black",size= 0.8)+
                    geom_segment(aes(x = 3, y = score_mean_PreB, xend = 4, yend = score_mean_PostB), color= "black",size= 0.8)
####
![grafik](https://user-images.githubusercontent.com/125254113/218566218-202f4c81-1166-4e25-af35-160abc100a5d.png)

#### add development for each participant (gray lines)
                    geom_line(data=dA,aes(x=xj, group=id), color="gray", alpha=.5)+
                    geom_line(data=dB,aes(x=xj, group=id), color="gray", alpha=.5)+
####
![grafik](https://user-images.githubusercontent.com/125254113/218566460-1438e355-fcfc-4dd4-b10a-ae8dfb9a9c56.png)

#### add development for each participant (gray lines)
                    geom_line(data=dA,aes(x=xj, group=id), color="gray", alpha=.5)+
                    geom_line(data=dB,aes(x=xj, group=id), color="gray", alpha=.5)+
####
