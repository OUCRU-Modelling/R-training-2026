## Exercise 1
vec <- seq(11,30)
vec[7]
## Use '-' to exclude elements
vec[-15]
## Use the concatenate function 'c'
vec[c(2,5)]
## odd numbers
index <- seq(1,length(vec),by=2)
vec[index]

## Exercise 2
fare <- titanic$fare
fare
sum(fare)
length(fare) # has value 10
sum(fare)/length(fare) # first compute the sum, divide by 10
fare/length(fare)
sum(fare/length(fare)) # first divide each value by 10, then compute the sum
mean(fare)
MeanFare <- sum(fare)/length(fare)
MeanFare
mean(fare)
# Calculate the standard deviation in three (baby) steps
fare-MeanFare
(fare-MeanFare)^2
numerator <- sum((fare-MeanFare)^2)
denominator <- (length(fare)-1)
StdFare  <- sqrt(numerator/denominator)
StdFare
sd(fare)



## Exercise 3
dim(titanic)
str(titanic)
mode(titanic$survived)


## Exercise 4
## a.
head(titanic, 10)
tail(titanic, 10)
## b.
titanic <- as.data.frame(titanic)
head(titanic, 10)
tail(titanic, 10)
## c.
summary(titanic)
## d.
quantile(titanic$age, probs=c(0.05,0.25,0.5,0.75,0.95), na.rm=TRUE)
quantile(titanic$fare, probs=c(0.05,0.25,0.5,0.75,0.95), na.rm=TRUE)
## the IQR (note that this is a single number)
IQR(titanic$age, na.rm=TRUE)
IQR(titanic$fare, na.rm=TRUE)
## the the standard deviation
sd(titanic$age, na.rm = TRUE)
sd(titanic$fare, na.rm = TRUE)
## e.
table(titanic$pclass)
table(titanic$sex)
table(titanic$sex, titanic$survived)
# has no added value because no missings
table(titanic$sex, titanic$survived, useNA = "always")
## f.
addmargins(table(titanic$sex, titanic$survived))
proportions(table(titanic$sex, titanic$survived))
proportions(table(titanic$sex, titanic$survived), margin = 1)


## Exercise 5
subset(titanic,age>70)[,c("name","home_dest")]
## or
subset(titanic,subset=age>70,select=c(name,home_dest))

subset(titanic, name=="Artagaveytia, Mr. Ramon")

first <- xtabs(~sex+survived, data=titanic, subset=(pclass=="1st"))
first
third <- xtabs(~sex+survived, data=titanic, subset=(pclass=="3rd"))
third
## similar results via
first <- with(subset(titanic, pclass=="1st"), table(sex,survived))
first
third <- with(subset(titanic, pclass=="3rd"), table(sex,survived))
third



## Exercise 6
titanic$sex  <- factor(titanic$sex)
titanic$pclass <- factor(titanic$pclass)
titanic$status <- factor(titanic$survived, labels=c("no","yes"))
summary(titanic)


## Exercise 7
titanic$dob <- as.Date(titanic$dob, origin = "1960/1/1")
table(format(titanic$dob, "%d"))
min(titanic$dob, na.rm = TRUE)
max(titanic$age, na.rm = TRUE)
min(titanic$dob, na.rm = TRUE) + max(titanic$age, na.rm = TRUE) * 365.25

