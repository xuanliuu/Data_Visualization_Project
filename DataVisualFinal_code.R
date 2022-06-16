#Setting the Working Directory
setwd("/Users/liuxuan/Desktop/Final")
#setwd("/Users/Owner/R_CODE")
getwd()
#Clearing the console to make reading easier
cat("\014") 
#Empty the Global Environment
rm(list=ls())

#--------------------------------read the dataset-------------------------------
entre <- read.csv("entre_data.csv", na.strings=c("","NA")) 
nrow(entre) #the number of rows
ncol(entre) #the number of col
str(entre) #structure of the dataset
summary(entre) #summary


#----------------------Transformation data from here----------------------------
# Installing the Needed Libraries:
#install.packages("stringr")
library(stringr) #call the needed library

names(entre)[names(entre) == 'y'] <- 'Entrepreneur' #rename the col "y"
summary(entre) 

table(is.na(entre)) #show missing values, False means no missing values
str_detect(entre,"NA") #detect missing values

na_location <- which(is.na(entre$ReasonsForLack)==TRUE) #Identify which observations have the missing data
na_location

entre[is.na(entre)]<-"Null(be an entrepreneur)" #fill out empty values

entre_complete <- entre #change a new dataset name after detecting NA value

entre_complete$ReasonsForLack <- tolower(entre_complete$ReasonsForLack) #make all words to lower-case characters
entre_complete$ReasonsForLack <- str_trim(entre_complete$ReasonsForLack, side="both") #trim the unnecessary spaces
class(entre_complete$ReasonsForLack)

#string matching
locations.interested <- grep("interested",entre_complete$ReasonsForLack)
entre_complete$ReasonsForLack[locations.interested] <- "just not interested"

locations.academic <- grep("academic pressure, lack of knowledge, not able to take a financial risk",entre_complete$ReasonsForLack)
entre_complete$ReasonsForLack[locations.academic] <- "academic pressure"

locations.academic <- grep("academic pressure, lack of knowledge, mental block",entre_complete$ReasonsForLack)
entre_complete$ReasonsForLack[locations.academic] <- "academic pressure"

locations.academic <- grep("academic pressure, unwillingness to take risk, lack of knowledge",entre_complete$ReasonsForLack)
entre_complete$ReasonsForLack[locations.academic] <- "academic pressure"

locations.academic <- grep("academic pressure, lack of knowledge, parental pressure, mental block, not able to take a financial risk",entre_complete$ReasonsForLack)
entre_complete$ReasonsForLack[locations.academic] <- "academic pressure"

locations.academic <- grep("academic pressure, not able to take a financial risk",entre_complete$ReasonsForLack)
entre_complete$ReasonsForLack[locations.academic] <- "academic pressure"

locations.academic <- grep("academic pressure, lack of knowledge",entre_complete$ReasonsForLack)
entre_complete$ReasonsForLack[locations.academic] <- "academic pressure"

locations.academic <- grep("academic pressure, unwillingness to take risk, parental pressure, not able to take a financial risk",entre_complete$ReasonsForLack)
entre_complete$ReasonsForLack[locations.academic] <- "academic pressure"

locations.academic <- grep("academic pressure, unwillingness to take risk, not able to take a financial risk",entre_complete$ReasonsForLack)
entre_complete$ReasonsForLack[locations.academic] <- "academic pressure"

locations.knowledge <- grep("lack of knowledge, mental block",entre_complete$ReasonsForLack)
entre_complete$ReasonsForLack[locations.knowledge] <- "lack of knowledge"

locations.knowledge <- grep("lack of knowledge, mental block, not able to take a financial risk",entre_complete$ReasonsForLack)
entre_complete$ReasonsForLack[locations.knowledge] <- "lack of knowledge"

locations.knowledge <- grep("lack of knowledge, not able to take a financial risk",entre_complete$ReasonsForLack)
entre_complete$ReasonsForLack[locations.knowledge] <- "lack of knowledge"

locations.knowledge <- grep("lack of knowledge, not willing to start a venture in india and waiting for future relocation",entre_complete$ReasonsForLack)
entre_complete$ReasonsForLack[locations.knowledge] <- "lack of knowledge"

locations.knowledge <- grep("lack of knowledge, parental pressure",entre_complete$ReasonsForLack)
entre_complete$ReasonsForLack[locations.knowledge] <- "lack of knowledge"

locations.knowledge <- grep("lack of knowledge, parental pressure, mental block, not able to take a financial risk",entre_complete$ReasonsForLack)
entre_complete$ReasonsForLack[locations.knowledge] <- "lack of knowledge"

locations.financial <- grep("not able to take a financial risk, not willing to start a venture in india and waiting for future relocation",entre_complete$ReasonsForLack)
entre_complete$ReasonsForLack[locations.financial] <- "not able to take a financial risk"

locations.Teaching <- grep("Teaching",entre_complete$EducationSector)
entre_complete$EducationSector[locations.Teaching] <- "Teaching Degree"

str(entre_complete)
table(entre_complete$ReasonsForLack)
table(entre_complete$EducationSector)

#turn Entrepreneur as categorical factors yes or no
entre_complete$Entrepreneur <- factor(entre$Entrepreneur, levels = c(0,1), labels = c("no","yes"), ordered= TRUE)

str(entre_complete) #check again structure of the dataset

#----------------------------------save new dataset-----------------------------
getwd()
write.csv(entre_complete,"entre_complete.csv")
