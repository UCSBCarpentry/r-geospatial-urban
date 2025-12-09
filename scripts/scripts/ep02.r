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

is.na(with_na) # This will produce a vector of logical values,

# you can count logicals with sum()
sum(is.na(with_na))


# to identify the values that are not missing we write the following
!is.na(with_na) # The ! operator means negation, i.e. not is.na(with_na)

# this is rather esoteric:
without_na <- with_na[!is.na(with_na)] # this notation will return only
# the elements that have TRUE on their respective positions

without_na

# the point is to show the square bracket [] notation.
with_na[3]



# Factors
nordic_str <- c("Norway", "Sweden", "Norway", "Denmark", "Sweden")
nordic_str # regular character vectors printed out
str(nordic_str)

# factor() function converts a vector to factor data type
nordic_cat <- factor(nordic_str)
nordic_cat # With factors, R prints out additional information - 'Levels'

str(nordic_cat)

levels(nordic_cat) # returns all levels of a factor vector.
nlevels(nordic_cat)

# R will want to make them alphabetic. You can force the order:
nordic_cat <- factor(
  nordic_cat,
  levels = c(
    "Norway",
    "Denmark",
    "Sweden"
  )
)

# now Norway will be the first category, Denmark second and Sweden third
nordic_cat

