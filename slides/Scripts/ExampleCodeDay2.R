library(readxl)
titanic <- read_excel("data/raw/Titanic3.xlsx", na="NA")
titanic <- as.data.frame(titanic)

##################################################
## Errors and warnings
##################################################

5 + "apple"
titanic$age[1,5]

as.numeric(c("1", "2", "banana"))
plot(fare ~ age, data=titanic, las=1, log="y")

##################################################
## exporting graphs
##################################################

pdf("output/BoxplotAgePlclass.pdf")
boxplot(age ~ pclass, data=titanic, cex.axis=1.5, cex.lab=1.5, las=1)
stripchart(age ~ pclass, data=titanic, method="jitter", add=TRUE, pch=19, vertical=TRUE)
dev.off()

pdf("output/BoxplotAgePlclass2.pdf",width=20,height=15)
boxplot(age ~ pclass, data=titanic, cex.axis=1.5, cex.lab=1.5, las=1)
stripchart(age ~ pclass, data=titanic, method="jitter", add=TRUE, pch=19, vertical=TRUE)
dev.off()

## a package that mimicks ggplot using base R graphics device

library(tinyplot) # https://grantmcdermott.com/tinyplot/
plt(I(fare+3) ~ age|pclass, data=titanic, theme=list(las=1), log="y", ylab="fare")
plt_add(type="lm")


plt(I(fare+3) ~ age, data=titanic, facet=~sex, theme=list(las=1), log="y", ylab="fare")
tinyplot_add(type="rug")

plt(age ~ pclass, data=titanic, type="violin")

##################################################
## Functions: order of arguments
##################################################

log(100)  # does not give 2
help(log)
log(100, 10) # log10(100) does the same
log(10, 100) # does not give 2, but the 100-log of 10
log(base=10, x=100)
log(b=10,x=100)

subset(titanic, age<=4)
subset(titanic, age) # gives an error
subset(titanic, age:sibsp) # gives an error and a warning
subset(titanic, sel=age) # correct
help(subset)
subset(titanic, s=age) # still gives an error

## Some functions have an ... argument
help(c)
c(3,6,8)
help(paste)
paste("Oxford","University","Clinical","Research","Unit")

##################################################
## Classes and methods
##################################################

summary(titanic$age) # numeric variable

summary(titanic$pclass) # character variable, better make it into a factor
titanic$pclass <- factor(titanic$pclass)
class(titanic$pclass)
summary(titanic$pclass)

summary(titanic$dob) # numeric variable, mode(titanic$dob) gives numeric
## make it into a Date variable
titanic$dob <- as.Date("15 April 1912", "%d %b %Y")+ (-titanic$age*365.25)
class(titanic$dob)
mode(titanic$dob)

help(summary) # Date class not mentioned
methods(summary) # separate help page for summary.Date
help(summary.Date)
summary.default(titanic$dob) # doesn't give numeric summary

## plot type adapted to class of independent variable
plot(age~fare, data=titanic)
plot(age~dob, data=titanic)
plot(age~pclass, data=titanic)


## Writing your own functions
IQR

good.morning <- function(work){
  if(work==TRUE) cat("wake up") else
    cat("you can stay in bed")
}
good.morning
good.morning()
good.morning(work=FALSE)

citation(package="tinyplot")

##################################################
## Lists
##################################################

class(titanic)
mode(titanic)

teachers <- c("Ronald","Hung","Tuyen")
rooms <- c(306,306,305)
c(teachers, rooms)
mode(c(teachers, rooms))

list(teachers, rooms)
RT <- list(teacher = teachers, room = rooms)
RT
RT$teacher
RT[[1]]

## output of regression model is object of mode list
AgeBySex <- lm(age~sex, data=titanic)
AgeBySex
mode(AgeBySex)
class(AgeBySex) # object of class lm
str(AgeBySex)
summary(AgeBySex)
help(summary.lm)


##################################################
## more transparent (and often shorter) code
##################################################

with(titanic, table(sex, survived))
## instead of table(titanic$sex, titanic$survived)

round(proportions(table(titanic$sex,titanic$survived)),2)

## pipe operator more transparent
titanic |>
    subset(select=c(sex,survived)) |>
    table() |>
    proportions() |>
    round(digits=2)

##################################################
## Apply functions
##################################################

x <- cbind(x1 = 3, x2 = c(4:1, 2:5))
dimnames(x)[[1]] <- letters[1:8]
x
apply(x, 2, mean)
col.sums <- apply(x, 2, sum)
col.sums
row.sums <- apply(x, 1, sum)
row.sums
rbind(cbind(x, Rtot = row.sums), Ctot = c(col.sums, sum(col.sums)))

lapply(titanic, summary)
lapply(titanic, mode)
sapply(titanic, mode)

with(titanic, tapply(age, sex, FUN= mean, na.rm=TRUE)) # |> class()
aggregate(age~sex, data=titanic, FUN=mean, na.rm=TRUE) # |> class()




