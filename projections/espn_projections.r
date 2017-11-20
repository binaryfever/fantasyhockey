###########################
# File: espn_projections.r
# Description: Downloads Fantasy Hockey Projections from ESPN.com
# Date: 11/16/2017
# Author: Fred McHale
# Notes:  with inspiration from Isaac Petersen (isaac@fantasyfootballanalytics.net)
#TODO: add position to data frame
###########################

#Load libraries
library("XML")
library("stringr")
library("ggplot2")
library("plyr")
library("gtools")
library("data.table")

#Functions
#source(paste(getwd(),"/R Scripts/Functions/Functions.R", sep=""))
source(paste(getwd(),"/functions/LeagueSettings.R", sep=""))


#Build espn URLs for player positions, and pages on the site
base_url <- paste0("http://games.espn.com/fhl/tools/projections?")

#The category id needed to distingush between positions
goalieCategoryId <- 2
forwardCategoryId <- 3
defenseCategoryId <- 4

#for paging
espn_pages <- c("0","40","80")

espn_goalie_urls <- paste0(base_url, "&slotCategoryGroup=", goalieCategoryId, "&startIndex=", espn_pages)
espn_defense_urls <- paste0(base_url, "&slotCategoryId=", defenseCategoryId , "&startIndex=", espn_pages)
espn_forward_urls <- paste0(base_url, "&slotCategoryId=", forwardCategoryId , "&startIndex=", espn_pages)

goalie_names <- c("Rank","Player","Goalie_Wins", "Goals_Against_Average", "SV_Percent", "Position")
defense_names <- forward_names <- c("Rank","Player","Goals","Assists","plus_minus","Pen_Minutes","PPP","ATOI","SOG", "Position")

#the projections dataframe with positions column

#Scrape espn goalie urls
goaliesList <- lapply(espn_goalie_urls, function(x){
        readHTMLTable(x, skip.rows = c(1), as.data.frame=TRUE, stringsAsFactors=FALSE)$playertable_0
    })


#create one dataframe from the goalies list
goaliesDataFrame <- rbind.fill(goaliesList)

#set the position column and name
goaliesDataFrame <- cbind(goaliesDataFrame, Position = 'goalie')

#set the column names for goalies
colnames(goaliesDataFrame) <- goalie_names

#Scrape espn defense urls
defenseList <- lapply(espn_defense_urls, function(x){
    readHTMLTable(x, skip.rows = c(1), as.data.frame=TRUE, stringsAsFactors=FALSE)$playertable_0
})

#create one dataframe from the defense list
defenseDataFrame <- rbind.fill(defenseList)

#set the position column and name
defenseDataFrame <- cbind(defenseDataFrame, Position = 'defense')

#set the column names from defensemen
colnames(defenseDataFrame) <- defense_names

#Scrape espn forward urls
forwardList <- lapply(espn_forward_urls, function(x){
    readHTMLTable(x, skip.rows = c(1), as.data.frame=TRUE, stringsAsFactors=FALSE)$playertable_0
})

#create one dataframe from the forward list
forwardDataFrame <- rbind.fill(forwardList)

#set the position column and name
forwardDataFrame <- cbind(forwardDataFrame, Position = 'forward')

#set the column names for forwards
colnames(forwardDataFrame) <- forward_names

#projections
espnProjections <- rbind.fill(goaliesDataFrame, defenseDataFrame, forwardDataFrame)

#replace symbols with zero
espnProjections$Goalie_Wins <- gsub('--', '0', espnProjections$Goalie_Wins)
espnProjections$Goals_Against_Average <- gsub('--', '0', espnProjections$Goals_Against_Average)
espnProjections$SV_Percent <- gsub('--', '0', espnProjections$SV_Percent)
espnProjections$SV_Percent <- gsub('--', '0', espnProjections$SV_Percent)
espnProjections$Goals <- gsub('--', '0', espnProjections$Goals)
espnProjections$Assists <- gsub('--', '0', espnProjections$Assists)
espnProjections$plus_minus <- gsub('--', '0', espnProjections$plus_minus)
espnProjections$Pen_Minutes <- gsub('--', '0', espnProjections$Pen_Minutes)
espnProjections$PPP <- gsub('--', '0', espnProjections$PPP)
espnProjections$ATOI <- gsub('--', '0', espnProjections$ATOI)
espnProjections$SOG <- gsub('--', '0', espnProjections$SOG)

#Convert variables from character strings to numeric
#for(i in 1:length(scoreCategories)) {
#    espnProjections[,scoreCategories[i]] <- sapply(espnProjections[,scoreCategories[i]], as.factor)
#}

#figure out points
#figure out goalie rank
#figure out defense rank
#figure out forward rank

