#####Repetitive Rainclouds #######

###Author Anna E. Fromm 

rm(list=ls())

library(openxlsx)
library(dplyr)
library(tidyverse)
library(ggpubr)
library(jtools)
library(GGally)
library(lavaan)
library(lattice)
library(ggplot2)
library(readr)
library(gghalves)
library(GGally)


setwd("XXXXX")

df1 <- read.xlsx("example_rain.xlsx"
                 ,sheet = "1", startRow = 1, colNames = TRUE, rowNames = FALSE, detectDates = FALSE,   skipEmptyRows = TRUE,   skipEmptyCols = TRUE,   rows = NULL,   cols = NULL,   sep.names = ".",   na.strings = "NA",   fillMergedCells = FALSE)


df1_long <-reshape(df1,
                   varying = c("DV_pre", "DV_post"),
                   v.names="DV_value",
                   timevar="DV",
                   times=c("DV_pre", "DV_post"),
                   new.row.names = 1:10000, 
                   direction = "long")


df1_long$id <- as.character(df1_long$id)
df0 <- df1_long %>%
  mutate(session = case_when(
    grepl("pre", DV) ~ "1",
    grepl("post", DV) ~ "2"
  ))

PreA <- df0[which(df0$group=="A"
                  & df0$session=="1"), ]
PreA <- PreA$DV_value

PostA <- df0[which(df0$group=="A"
                   & df0$session=="2"), ]
PostA <- PostA$DV_value

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

PreB <- df0[which(df0$group=="B"
                  & df0$session=="1"), ]
PreB <- PreB$DV_value

PostB <- df0[which(df0$group=="B"
                   & df0$session=="2"), ]
PostB <- PostB$DV_value

nB <-length(PreB)
dB <-data.frame(y=c(PreB, PostB),
                x=rep(c(3,4), each=nB),
                id =factor(rep(1:nB,2)))
set.seed(321)
dB$xj <-jitter(dB$x,amount=.09)

score_mean_PreB <- mean(PreB, na.rm=TRUE)
score_mean_PostB <- mean(PostB, na.rm=TRUE)
y <- c(score_mean_PreB, score_mean_PostB)
x <- c(3,4)
dfmB<- data.frame(y, x)

ggplot(NULL, aes(y=y))+
  geom_point(data=dA %>% filter(x=="1"), aes(x=xj), color="orange", size=6.0, alpha=.6)+
  geom_point(data=dA %>% filter(x=="2"), aes(x=xj), color="red", size=6.0, alpha=.6)+
  geom_point(data=dB %>% filter(x=="3"), aes(x=xj), color="skyblue2", size=6.0, alpha=.6)+
  geom_point(data=dB %>% filter(x=="4"), aes(x=xj), color="dodgerblue", size=6.0, alpha=.6)+
  geom_point(data=dfmA %>% filter(x=="1"), aes(x=x), color="black", size=8, shape=18)+
  geom_point(data=dfmA %>% filter(x=="2"), aes(x=x), color="black", size=8, shape=18)+
  geom_point(data=dfmB %>% filter(x=="3"), aes(x=x), color="black", size=8, shape=18)+
  geom_point(data=dfmB %>% filter(x=="4"), aes(x=x), color="black", size=8, shape=18)+
  geom_segment(aes(x = 1, y = score_mean_PreA, xend = 2, yend = score_mean_PostA), color= "black",size= 0.8)+
  geom_segment(aes(x = 3, y = score_mean_PreB, xend = 4, yend = score_mean_PostB), color= "black",size= 0.8)+
  geom_line(data=dA,aes(x=xj, group=id), color="gray", alpha=.5)+
  geom_line(data=dB,aes(x=xj, group=id), color="gray", alpha=.5)+
  geom_half_boxplot(
    data = dA %>% filter(x=="1"), aes(x=x, y = y), position = position_nudge(x = -.51),
    side = "r",outlier.shape = NA, center = TRUE, errorbar.draw = FALSE, width = .2,
    fill = "orange")+
  geom_half_boxplot(
    data = dA %>% filter(x=="2"), aes(x=x, y = y), position = position_nudge(x = -1.4),
    side = "r",outlier.shape = NA, center = TRUE, errorbar.draw = FALSE, width = .2,
    fill = "red")+
  geom_half_boxplot(
    data = dB %>% filter(x=="3"), aes(x=x, y = y), position = position_nudge(x = 2.2),
    side = "r",outlier.shape = NA, center = TRUE, errorbar.draw = FALSE, width = .2,
    fill = "skyblue2")+
  geom_half_boxplot(
    data = dB %>% filter(x=="4"), aes(x=x, y = y), position = position_nudge(x = 1.32),
    side = "r",outlier.shape = NA, center = TRUE, errorbar.draw = FALSE, width = .2,
    fill = "dodgerblue")+
  geom_half_violin(
    data=dA %>% filter(x=="1"),aes(x=x, y=y), position=position_nudge(x=-0.6),
    side="l", fill="orange", alpha=.5, color="orange", trim=TRUE)+
  geom_half_violin(
    data=dA %>% filter(x=="2"),aes(x=x, y=y), position=position_nudge(x=-1.6),
    side="l", fill="red", alpha=.5, color="red", trim=TRUE)+
  geom_half_violin(
    data=dB %>% filter(x=="3"),aes(x=x, y=y), position=position_nudge(x=2.7),
    side="r", fill="skyblue2", alpha=.5, color="skyblue2", trim=TRUE)+
  geom_half_violin(
    data=dB %>% filter(x=="4"),aes(x=x, y=y), position=position_nudge(x=1.7),
    side="r", fill="dodgerblue", alpha=.5, color="dodgerblue", trim=TRUE)+
  scale_x_continuous(breaks=c(1,2,3,4), labels=c("Pre", "Post", "Pre", "Post"))+
  xlab("Session") +ylab("DV")+
  labs(title = "Dependent variable over time")+
  theme_bw()
