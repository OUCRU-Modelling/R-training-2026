# -------- Set up -------------
options(warn=0) # allow warnings
library(readxl)
library(ggplot2)

titanic <- read_excel("data/raw/Titanic3.xlsx", na = "NA")

# ========== Exercise 1 =============
## Step 1 ----------------------
ggplot(titanic) +
  geom_point(aes(x = age, y = fare)) +
  ylab("fare paid (GBP)")
# Expect Warning message:
# Removed 264 rows containing missing values or values outside the scale range (`geom_point()`).
# -> This is because some rows have missing age value
# check this by running: titanic[is.na(titanic$age), ]

# Bonus task
ggplot(titanic) +
  geom_point(aes(x = age, y = fare)) +
  ylab("fare paid (GBP)") +
  coord_polar()

## Step 2 ---------------------
ggplot(titanic, aes(x = age, y = fare)) +
  geom_point() +
  geom_smooth(method = "lm") +
  ylab("fare paid (GBP)")


## Step 3 ---------------------
ggplot(titanic, aes(x = age, y = fare)) +
  geom_point() +
  geom_smooth(method = "lm") +
  scale_y_log10("fare paid (GBP)")
# Again, this should raise a Warning message:
# In scale_y_log10("fare paid (GBP)") : log-10 transformation introduced infinite values.
# -> This is because some rows have fare=0, and log10(0) does not exist
# check this by running: titanic[titanic$fare==0, ]

# Quick fix to the Warning message
ggplot(titanic, aes(x = age, y = fare+3)) +
  geom_point() +
  geom_smooth(method = "lm") +
  scale_y_log10("fare paid (GBP)")

## Step 4 ---------------------
ggplot(titanic, aes(x = age, y = fare+3, color = pclass)) +
  geom_point() +
  geom_smooth(method = "lm") +
  scale_y_log10("fare paid (GBP)")

## Step 5 ---------------------
ggplot(titanic, aes(x = age, y = fare+3, color = pclass)) +
  geom_point() +
  geom_smooth(method = "lm") +
  geom_rug() +
  scale_y_log10("fare paid (GBP)") +
  facet_wrap(~sex)

## Step 6 ----------------------
# renv::install("OUCRU-Modelling/oucru")
library(oucru)

# Example plot
ggplot(titanic, aes(x = age, y = fare+3, color = pclass)) +
  geom_point() +
  geom_smooth(method = "lm") +
  geom_rug() +
  scale_y_log10("fare paid (GBP)") +
  facet_wrap(~sex) +
  scale_color_oucru_d() +
  theme_bw()

## Step 7 ---------------------
# optionally, change to your preferred path
ggsave("output/titanic_fare_plot.png", width = 7, heigh = 5)


# =========== Exercise 2 ===================
## Histogram -----------
ggplot(titanic, aes(x = age)) +
  geom_histogram() +
  facet_wrap(~pclass)


## Boxplot --------------
ggplot(titanic) +
  geom_boxplot(
    aes(y = age, x = pclass)
  )

# with data points
ggplot(titanic, aes(y = age, x = pclass)) +
  geom_boxplot() +
  geom_jitter(color = "red", alpha = .2)

## Violin plot ------------
ggplot(titanic, aes(y = age, x = pclass)) +
  geom_violin() +
  geom_jitter(color = "red", alpha = .2) +
  theme_bw()

# ========= Exercise 3 =====================
ggplot(titanic, aes(x = age, y = survived, color = sex)) +
  geom_smooth(method = "loess") +
  geom_jitter(width = 0, height = .05, alpha = .5) +
  facet_wrap(~pclass) +
  coord_cartesian(ylim = c(-.1, 1.1)) +
  scale_color_oucru_d(palette = "group4") +
  theme_bw() +
  theme(legend.position = 'top')
