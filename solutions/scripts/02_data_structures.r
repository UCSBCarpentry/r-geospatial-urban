# aka episode 2

x <- 5
y <- 2.5

# boolean is only TRUE or FALSE
z <- TRUE
z

text <- "something"

# can't do that.
text + z

numeric_vector <- c(2,6,3)
str(numeric_vector)

character_vector <- c("Amsterdam", "'s Gravenhage", "Delft")

# challenge
# what happens when we mix?
# Combinging vectors

ab_vector <- c("a", "b")
abcd_vector <- c(ab_vector, "c", "d")
mixed <- c(abcd_vector, x)
mixed

x <- as.integer(5)

# NA values
with_na <- c(1,2,1,1,NA,3,NA)
mean(with_na)
mean(with_na, na.rm=TRUE)

# question
with_na_test <- c(1,2,1,1,,3,NA)

# Factors
# categorical data
nordic_str <- c("Norway", "Sweden", "Norway", "Denmark", "Sweden")

nordic_cat <- factor(nordic_str)
str(nordic_cat)
levels(nordic_cat)

# ordering stuff: note the default is alphabetical

# let's try a new package
library(forcats)
nordic_cat <- fct_relevel(nordic_cat, "Norway", "Denmark", "Sweden")
nordic_cat

# any disadvantaged to factors?
# can't add a new value on the fly.
nordic_cat_2 <- c(nordic_cat, "Sweeden", "Finland")
str(nordic_cat_2)

