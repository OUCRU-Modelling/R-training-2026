#############################################################
### Base graphics
#############################################################

library(readxl)
titanic <- read_excel("data/raw/Titanic3.xlsx", na="NA")

#############################################################
## Exercise 1
#############################################################
plot(titanic$age, titanic$fare)
## Formula based specification
plot(fare ~ age, data=titanic)
## Exercise 1. What would you like to change to make it good enough for publication?

## http://cran.r-project.org/doc/contrib/Baggott-refcard-v2.pdf
## labels
plot(titanic$age, titanic$fare, xlab="age", ylab="fare paid (GBP)")

## rotate labels along y-axis
plot(fare ~ age, data=titanic, las=1)

#############################################################
## Exercise 2: add regression line
#############################################################
abline(lm(fare~age, data=titanic), col="red")

#############################################################
## Exercise 3: transform or change scale for fare
#############################################################
## Use log10 of fare
plot(log10(fare)~age, data=titanic)
abline(lm(log10(fare)~age, data=titanic, subset=fare>0), col="red")

## Plot using logarithmic scale for fare
plot(fare ~ age, data=titanic, las=1, log="y")
## Warning: log(0) does not exist
table(titanic$fare==0) # 17 paid fare 0
points(fare+3~age, data=titanic, col="red", subset=fare==0)
title("Fare paid for ticket on Titanic versus age")
## Why do you see only 7 red circles?

## change plotting character
plot(fare ~ age, data=titanic, las=1, log="y")
colors()
points(fare+3~age, data=titanic, col="red", subset=fare==0, pch=25, bg="red")
title("Fare by age")

## add text and arrows
text(48, 450, "So expensive", col="red")
arrows(41,455,37,500, length=0.1)
arrows(54,455,57.5,500, length=0.1)

## Use base graphics for simple tasks
## Example: explain logarithmic scale via graph
x <- seq(1,500,by=1)
plot(x, log10(x))

plot(x, log10(x), type="l", xaxs="i")
segments(0,2,100,2,lty=2)
arrows(100,2,100,0,lty=2)


#############################################################
## Exercise 4: color points by passenger class
#############################################################
plot(fare+3 ~ age, data=titanic, las=1, log="y", col=match(pclass,unique(pclass)), ylab="fare")
## If you first make pclass into a factor you can use as.numeric
titanic$pclass <- factor(titanic$pclass)
plot(fare+3 ~ age, data=titanic, las=1, log="y", col=as.numeric(pclass), ylab="fare")


## Information on colors:
## https://stackoverflow.com/questions/62184539/colors-of-base-r-plots-have-changed-can-i-revert-to-old-palette

#############################################################
## Exercise 5: separate plot by sex with rug
#############################################################
par(mfrow=c(1,2))
plot(fare+3 ~ age, data=titanic, las=1, log="y", ylab="fare", subset=sex=="female")
rug(subset(titanic,sex=="female")$age)
plot(fare+3 ~ age, data=titanic, las=1, log="y", ylab="fare", subset=sex=="male")
rug(subset(titanic,sex=="male")$age)
par(mfrow=c(1,1))


#############################################################
## Exercise 6: Make a histogram of age
#############################################################

hist(titanic$age)
hist(titanic$age, breaks=15, cex.axis=1.5, cex.lab=1.5, xlab="age")

#############################################################
## Exercise 7: Make a boxplot of age by passenger class
#############################################################
plot(age ~ pclass, data=titanic)
boxplot(age ~ pclass, data=titanic, cex.axis=1.5, cex.lab=1.5, las=1)
stripchart(age ~ pclass, data=titanic, method="jitter", add=TRUE, pch=19, vertical=TRUE)

##################################################
## Exercise regression and pipe operator
##################################################

with(titanic, tapply(fare, pclass, FUN= summary))
aggregate(fare~pclass, data=titanic, FUN=summary)


FareByAge <- lm(log(fare+3)~age, data=titanic)
FareByAge
summary(FareByAge)

titanic |>
    transform(age=age/10) |>
    lm(log(fare+3)~age, data=_) |>
    summary()




