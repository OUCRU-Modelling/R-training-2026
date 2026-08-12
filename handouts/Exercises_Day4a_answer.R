
library(ggplot2)
library(ggthemes)

## exercise 3
NightRose <- read.csv("data/raw/NightingaleRose.csv")
NightRose$Date <- as.Date(NightRose$Date)

## stacked bar chart
ggplot(NightRose, aes(Date,perc,fill=cause)) + geom_col(position="stack") + geom_vline(xintercept=as.Date("1855-03-15"), linetype="dashed", col="grey50")

## dodged bar chart
ggplot(NightRose, aes(Date,perc,fill=cause)) + geom_col(position="dodge") + geom_vline(xintercept=as.Date("1855-03-15"), linetype="dashed", col="grey50")


## change background colour
ggplot(NightRose, aes(Date,perc,fill=cause)) + geom_rect(
  aes(xmin = as.Date("1854-03-15"), xmax = as.Date("1855-03-15"), ymin = -Inf, ymax = Inf),
  alpha = .2, fill="moccasin") + geom_col(position="dodge") +
  geom_vline(xintercept=as.Date("1855-03-15"), linetype="dashed", col="grey50") + scale_x_date(expand=c(0,0))

##
ggplot(NightRose, aes(Date,perc,color=cause)) + geom_line(size=2) + geom_vline(xintercept=as.Date("1855-03-15"), linetype="dashed", col="grey50")

ggplot(NightRose, aes(Date,perc,group=cause,color=cause)) + geom_line(size=0.2,col="grey50") + geom_point(size=5) + geom_vline(xintercept=as.Date("1855-03-15"), linetype="dashed", col="grey50")


## exercise 4:
Cost <- read.csv("data/raw/ICUCost.csv")
library(ggplot2)
library(ggthemes)

## (b)
ggplot(data=Cost,aes(x=Severity,y=Perc,fill=Type))+
 geom_bar(stat='identity')+
 ggtitle("Percentage share of the cost in ICU")+
    theme_classic()

## via geom_col:
ggplot(data=Cost,aes(x=Severity,y=Perc,fill=Type))+
    geom_col()+
 ggtitle("Percentage share of the cost in ICU")+
    theme_classic()

## same figure via reversing map to x-axis and y-axis
ggplot(data=Cost,aes(x=Perc,y=Severity,fill=Type))+
 geom_col()+
 ggtitle("Percentage share of the cost in ICU")+
    theme_classic()

## change the theme (ggthemes package needed) and use another colour palette
ggplot(data=Cost,aes(x=Severity,y=Perc,fill=Type))+
 geom_bar(stat='identity')+
 scale_fill_brewer(palette='Set2')+
 coord_flip()+
 ggtitle("Percentage share of the cost in ICU")+
 theme_fivethirtyeight()+
    scale_colour_fivethirtyeight()

## (c)
ggplot(data=Cost,aes(x=Type,y=Perc,fill=Type))+
 geom_bar(stat='identity')+
 scale_fill_brewer(palette='Set2')+
 facet_grid(Ventilated ~ Disease)+
 ggtitle("Percentage share of the cost in ICU")+
 theme_fivethirtyeight()+
    scale_colour_fivethirtyeight()

## without colors, reverse mapping and change theme:
ggplot(data=Cost,aes(x=Type,y=Perc))+
 geom_bar(stat='identity')+
 facet_grid(Ventilated ~ Disease)+
 coord_flip()+
 ggtitle("Percentage share of the cost in ICU")+
 theme_bw()

## (d) Use coord_flip()
ggplot(data=Cost,aes(x=Type,y=Perc,group=Disease,colour=Disease))+
 geom_line(size=1)+
 facet_wrap(~ Ventilated)+
 ggtitle("Percentage share of the cost in ICU")+
    theme_bw() + coord_flip()

## reversing the mapping to x-axis and y-axis gives strange results
ggplot(data=Cost,aes(Perc,Type,group=Disease,colour=Disease))+
 geom_line(size=1)+
 facet_wrap(~ Ventilated)+
 ggtitle("Percentage share of the cost in ICU")+
 theme_bw()

## Connecting the lines may generate confusion, because it's interpreted as a slope
## Therefore, this alternative may be better:
ggplot(data=Cost,aes(x=Type,y=Perc,group=Disease,colour=Disease))+
 geom_line(size=0.2,col="grey50")+
 geom_point(size=5) +
 facet_wrap(~ Ventilated)+
 ggtitle("Percentage share of the cost in ICU")+
 theme_bw()  + coord_flip()


#####################################################################################
## we make the same graphs, but first reorder type of cost by average percentage
library(forcats)
Cost$CostType <- fct_reorder(Cost$Type,Cost$Perc,mean)

## (b)
ggplot(data=Cost,aes(x=Perc,y=Severity,fill=CostType))+
 geom_bar(stat='identity')+
 ggtitle("Percentage share of the cost in ICU")+
    theme_classic()


## (c)
ggplot(data=Cost,aes(x=CostType,y=Perc))+
 geom_bar(stat='identity')+
 facet_grid(Ventilated ~ Disease)+
 coord_flip()+
 ggtitle("Percentage share of the cost in ICU")+
 theme_bw()

## (d)
ggplot(data=Cost,aes(x=CostType,y=Perc,group=Disease,colour=Disease))+
 geom_line(size=1)+
 facet_wrap( ~ Ventilated)+
 ggtitle("Percentage share of the cost in ICU")+
 theme_bw()

ggplot(data=Cost,aes(x=CostType,y=Perc,group=Disease,colour=Disease))+
 geom_line(size=0.2,col="grey50")+
 geom_point(size=5) +
 facet_wrap( ~ Ventilated)+
 ggtitle("Percentage share of the cost in ICU")+
 theme_bw()  + coord_flip()


