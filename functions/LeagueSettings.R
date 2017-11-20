###########################
# File: LeagueSettings.R
# Description: User sets league settings
# Author: Fred McHale
# Notes: with inspiration from Isaac Petersen (isaac@fantasyfootballanalytics.net)
# To do: Determine scoring rules
###########################

#Roster
numGoalies <- 1
numDefense <- 1
numForwards <- 3
numTotalPlayers <- 5

#League settings

#Variable names
prefix <- c("name","pos","sourceName")
sourceSpecific <- c("name","team")
scoreCategories <- c("Goalie_Wins", "Goals_Against_Average", "SV_Percent")
calculatedVars <- c("positionRank","overallRank","points","pointsLo","pointsHi","vor","pick","risk","sdPts","sdPick")
varNames <- c(calculatedVars, scoreCategories)
finalVarNames <- c("name","pos","team","sourceName","player","playerID","season", "playerId", "analystId", varNames)

#Scoring
goal_multiplier <- 12      #12 pts per goal
assist_multiplier <- 8      #8 pts per assist
shorthand_goal_bonus_multiplier <- 8      #8 pts bonus for shorthanded goal
shorthand_assist_multiplier <- 6      #6 pts bonus for shorthanded assits
shot_on_goal_multiplier <- 2     #2 points for shots on goal
hit_multiplier <- 2      #2 points for hits
goalie_win_multiplier <- 12      #12 pts per goalie win
save_multiplier <- 0.5  #half a point per goalie save
zero_goals_against_multiplier <- 12
one_goal_against_multiplier <- 8
two_goals_against_multiplier <- 4
three_goals_against_multiplier <- 0
four_goals_against_multiplier <- -3
five_plus_goals_against_multiplier <- -6


scoringRules <- list(
    G = data.frame(dataCol = c("goalWins", "saves", "zeroGoalsAgainst", "oneGoalsAgainst", "twoGoalsAgainst", "threeGoalsAgainst", "fourGoalsAgainst", "fivePlusGoalsAgainst"),
                    multiplier = c(12, 0.5, 12, 8, 4, 0, -3, -6 )),
    DandF = data.frame(dataCol = c("goal", "assist", "shorthandGoalBonus", "shorthandAssistBonus", "shotOnGoal", "hit"),
                    multiplier = c(12, 8, 8, 6, 2, 2))
)


#Projections
#c("CBS", "ESPN", "Yahoo") #c("Accuscore", "CBS1", "CBS2", "EDSfootball", "ESPN", "FantasyFootballNerd", "FantasyPros", "FantasySharks", "FFtoday", "Footballguys1", "Footballguys2", "Footballguys3", "Footballguys4", "FOX", "NFL", "numberFire", "WalterFootball", "Yahoo")
sourcesOfProjections <- c("ESPN") #, "Dodds-Norton", "Dodds", "Tremblay", "Herman", "Henry", "Wood", "Bloom") 
sourcesOfProjectionsAbbreviation <- c("espn") #c("accu", "cbs1", "cbs2", "eds", "espn", "ffn", "fp", "fs", "fftoday", "fbg1", "fbg2", "fbg3", "fbg4", "fox", "nfl", "nf", "wf", "yahoo")

#Weights applied to each source in calculation of weighted average of projections
#weight_accu <- 1    #Accuscore
#weight_cbs1 <- 1    #Jamey Eisenberg
#weight_cbs2 <- 1    #Dave Richard"
#weight_eds <- 1     #EDS Football
weight_espn <- 1    #ESPN
#weight_ffn <- 1     #Fantasy Football Nerd
#weight_fbg1 <- 1    #Footballguys: David Dodds
#weight_fbg2 <- 1    #Footballguys: Bob Henry
#weight_fbg3 <- 1    #Footballguys: Maurile Tremblay
#weight_fbg4 <- 1    #Footballguys: Jason Wood
#weight_fox <- 1    #FOX
#weight_fp <- 1      #FantasyPros
#weight_fs <- 1      #FantasySharks
#weight_fftoday <- 1 #FFtoday
#weight_nfl <- 1     #NFL.com
#weight_nf <- 1      #numberFire
#weight_wf <- 1      #WalterFootball
#weight_yahoo <- 1   #Yahoo 

sourceWeights <- c(
#    "Jamey Eisenberg"   = 1, 
#    "Dave Richard"      = 1, 
#    "Yahoo Sports"      = 1, 
    "ESPN"              = 1 
#    "NFL"               = 1, 
#    "FOX Sports"        = 1, 
#    "FFtoday"           = 1,
#    "NumberFire"        = 1, 
#    "FantasyPros"       = 1,
#    "Dodds-Norton"      = 1, 
#    "Dodds"             = 1, 
#    "Tremblay"          = 1, 
#    "Herman"            = 1, 
#    "Henry"             = 1, 
#    "Wood"              = 1, 
#    "Bloom"             = 1
) 


#Number of players at each position drafted in Top 100 (adjust for your league)
#qbReplacements <- 15
#rbReplacements <- 37
#wrReplacements <- 36
#teReplacements <- 11

#Alternative way of calculating the number of players at each position drafted in Top 100 based on league settings
numTeams <- 10  #number of teams in league
numGoalies <- 1      #number of avg goalies in starting lineup
numDefense <- 1    #number of avg defensemen in starting lineup
numForwards <- 3    #number of avg forwards in starting lineup

goalieReplacements <- print(ceiling(numGoalies*numTeams*1.7))
defenseReplacements <- print(ceiling(numDefense*numTeams*1.4))
forwardReplacements <- print(ceiling(numForwards*numTeams*1.4))
