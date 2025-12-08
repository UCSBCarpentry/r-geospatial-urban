# solution for ep 2 of urbanism


# c()   --- the most basic of creation functions.


# vector of numbers - numeric data type.
numeric_vector <- c(2, 6, 3)
numeric_vector

str(numeric_vector)

character_vector <- c('Amsterdam', "'s Gravenhage", 'Delft')
character_vector

str(character_vector)

logical_vector <- c(TRUE, FALSE, TRUE)
logical_vector

str(logical_vector)

# remember: names are arbitrary

# Combining vectors
ab_vector <- c("a", "b")
ab_vector

abcd_vector <- c(ab_vector, "c", "d")
abcd_vector

# challenge
challenge_vector <- c(abcd_vector, numeric_vector)
challenge_vector

str(challenge_vector)


# dealing with NA
# NA is always problematic for means and medians
with_na <- c(1, 2, 1, 1, NA, 3, NA) # vector including missing values

mean(with_na) # mean() function cannot interpret the missing values

# You can add the argument na.rm = TRUE to calculate the result while
# ignoring the missing values.
mean(with_na, na.rm = TRUE)

