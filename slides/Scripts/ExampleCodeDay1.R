############################################################
### Day 1
#############################################################

## R as a pocket calculator I
2+7
2*7
7/2
2^7; 2**7

## R as a pocket calculator II
sqrt(2)
log10(1000)
10^3
sum(c(1,2,3,4,5)); sum(1:5)
pi

## Assignment
x <- sqrt(2)
print(x)     # show value
x            # shortcut for print(x)
print(x, digits = 10) # more digits
x^2
x
x <- x^2 # overwrite value
x

## Data: selections within a single column
titanic <- data.frame(
    pclass=rep(c("1st","2nd","3rd"),c(4,2,4)),
    survived=c(1,0,0,0,1,1,0,0,0,0),
    name=c("Allison, Master. Hudson Trevor","Dulles, Mr. William Crothers","McCarthy, Mr. Timothy J","Walker, Mr. William Anderson", "Duran y More, Miss. Asuncion", "Mellinger, Miss. Madeleine Viol","Abbott, Master. Eugene Joseph", "Calic, Mr. Petar","Flynn, Mr. James", "Johnston, Miss. Catherine Helen"),
    age= c(0.9167,39,54,47,27,13,13,17,NA,NA),
	fare=c(151.55,29.7,51.8625,34.0208,13.8583,19.5,20.25,8.6625,7.75,23.4))

titanic$age
titanic$age[1,5]    # gives an error
titanic$age[c(1,5)] # c is function to combine values
titanic$age[c(6,7,8,9,10)]
6:10               # short notation for c(6,7,8,9,10)
seq(6,10,by=1)     # same as 6:10
titanic$age[6:10]
seq(1,10,by=2)
titanic$age[seq(1,10,by=2)]

## Data: selection of rows and columns
titanic[2:3, c(3,1)]
titanic[6,10]
titanic[c(2,3), c("name","pclass")]

## Many calculation functions are vectorized
titanic$age/10 # age per 10 years for each person
c(2, 15) + c(10, -3)

## Modes
seq(0,2,by=0.25)
-2 < 2
c("Hung", "Ronald")
letters
as.character(seq(0,2,by=0.25))
as.numeric(c(FALSE,TRUE))

## Modes: logical (I)
titanic$fare
titanic$fare[c(TRUE,FALSE,TRUE,TRUE, FALSE, TRUE,FALSE,TRUE,TRUE, FALSE)]
titanic$fare>40
titanic$pclass[titanic$fare>40]
"Hung" > "Ronald"
titanic$pclass=="1st"
sum(titanic$pclass=="1st")

## Modes: logical (II)
TRUE & FALSE
TRUE | FALSE
!TRUE
titanic$fare
titanic$fare > 10 & titanic$fare < 40
!(titanic$fare < 10 | titanic$fare > 40)
titanic$fare[titanic$fare > 10 & titanic$fare < 40]

## Data Import
library(readxl)
titanic <- read_excel("data/raw/Titanic3.xlsx", na = "NA")

## Missing data
titanic$age==NA # not correct
3==NA # NA is NA, whatever the comparison value
is.na(3)
is.na(titanic$age)
table(is.na(titanic$age))

table(titanic$age)
table(titanic$age, useNA="always")

mean(titanic$age)
mean(titanic$age, na.rm=TRUE)
quantile(titanic$age)


## Selection by name
teachers <- c("Ronald","Hung","Tuyen")
rooms <- c(306,306,305)
names(rooms) <- teachers
rooms
names(rooms)
rooms["Ronald"]
dimnames(titanic)
 titanic[c(2,3),c("name","age")]

## more efficient row selections: subset
subset(titanic, pclass %in% c("1st","2nd"))$survived
table(subset(titanic, pclass %in% c("1st","2nd"))$survived)

subset(titanic, embarked=="Southampton" & age<2)
subset(titanic, fare<10 & age>70)
subset(titanic, sibsp %in% c(1,5) & (age==10|age>70))

## subset as function argument
xtabs(~survived, data=titanic, subset=(sex=="male"))
## do not write:
xtabs(~titanic$survived, data=titanic, subset=(titanic$sex=="male"))

#############################################################
## more efficient column selections
head(subset(titanic, select= c(sex,fare)))
head(subset(titanic, select= sex:fare))
head(subset(titanic, select= -(sex:fare)))

#############################################################
## Factors
table(titanic$sex)
titanic$sex <- factor(titanic$sex)
levels(titanic$sex) # female comes first
as.numeric(titanic$sex)[1:100]
titanic$sex <- relevel(titanic$sec, ref="male")
## or directly when creating the factor:
titanic$sex <- factor(titanic$sex, levels=c("male","female"))
table(titanic$sex)

levels(titanic$sex) <- c("M","F")
titanic$sex <- factor(titanic$sex, labels=c("M","F"))

head(titanic)
titanic$status <- factor(titanic$survived, labels=c("no","yes"))
titanic$pclass <- factor(titanic$pclass)

#############################################################
## Dates
help(as.Date)
as.Date("15 April 1912") # R cannot interpret
as.Date("15 April 1912", format="%d %B %Y")
as.Date("15 April 12", format="%d %B %y")
julian(as.Date("15 April 1912", "%d %b %Y")) # days before Jan 1st, 1970
titanic$dob[1:10] # the days are relative to the time origin in Stata, Jan 1st, 1960
as.Date(titanic$dob,origin="1960-1-1")[1:10]
## Indeed, same as:
(as.Date("15 April 1912", "%d %B %Y") - titanic$age*365.25)[1:10]
## some further possible date formats
as.Date("15041912", "%d%m%Y")
as.Date("150412", "%d%m%y")
## convert to other format via format function
format(as.Date("1912April15", "%Y%b%d"),"%A %B %d, %Y")
# combine three columns:
a <- 14
b <- "January"
d <- 2018
paste(a,b,d,collapse=" ")
as.Date(paste(a,b,d,collapse=" "),"%d %b %Y")

library(anytime)
anydate(titanic$dob[1:10])
## ten years difference because the R date origin is assumed in anydate function
## the lubridate package provide an easy way to subtract 10 years
library(lubridate)
anydate(titanic$dob[1:10]) -  years(10)
## anydate recognizes many date formats, but not all
anydate("15041912") # doesn't work
anydate("19120415") # does work


