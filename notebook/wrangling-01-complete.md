Data Wrangling in R, Lesson 1
================
Christopher Prener, Ph.D.
(January 23, 2019)

## Introduction

This is the notebook for the first data wrangling lesson. Today, we’ll
be covering how to work with existing variables. This includes the
`clean_names()` function from `janitor` as well as the `rename()` and
`select()` functions from `dplyr`.

## Dependencies

This notebook requires two packages from the `tidyverse` as well as two
additional packages:

``` r
# tidyverse packages
library(dplyr)     # data wrangling
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
library(readr)     # read and write csv files

# data wrangling
library(janitor)   # data wrangling

# manage file paths
library(here)      # manage file paths
```

    ## here() starts at /Users/chris/GitHub/DSS/wrangling-01

## Reading Data

This was more fully covered in a [previous
seminar](https://github.com/slu-dss/research-02). Today, we’ll review
how to read `.csv` files into `R`. We have to files in the `data/`
subdirectory of our project:

1.  `mpg_messy.csv` - a version of the `mpg` data from `ggplot2` with
    *terrible* column names
2.  `starwars_messy.csv` - a version of the `starwars` data from `dplyr`
    with equally horrible column names

To read `.csv` files into `R`, we’ll use the `readr` package’s
`read_csv()` function. **This is different from `utils::read.csv()`\!**

``` r
mpg <- read_csv(here("data", "mpg_messy.csv"))
```

    ## Parsed with column specification:
    ## cols(
    ##   `manufacturer's name` = col_character(),
    ##   `vehicle model` = col_character(),
    ##   `Engine Displacement` = col_double(),
    ##   YEAR = col_double(),
    ##   `# of cylinders` = col_double(),
    ##   `transmission type` = col_character(),
    ##   `drivetrain type` = col_character(),
    ##   `city fuel efficiency (mpg)` = col_double(),
    ##   `highway fuel efficency (mpg)` = col_double(),
    ##   `vehicle class` = col_character()
    ## )

Now, you try the same syntax out - import the `starwars_messy.csv` data
from the same source:

``` r
starwars <- read_csv(here("data", "starwars_messy.csv"))
```

    ## Parsed with column specification:
    ## cols(
    ##   `character name` = col_character(),
    ##   HEIGHT = col_double(),
    ##   MASS = col_double(),
    ##   `hair color` = col_character(),
    ##   `skin color` = col_character(),
    ##   `eye color` = col_character(),
    ##   `year of bith` = col_double(),
    ##   gender = col_character(),
    ##   homeworld = col_character(),
    ##   species = col_character()
    ## )

## Quickly Exploring Data

To quickly explore the `mpg` data, we’ll take a look at both the column
names and some sample values using
    `utils::str()`:

``` r
str(mpg)
```

    ## Classes 'spec_tbl_df', 'tbl_df', 'tbl' and 'data.frame': 234 obs. of  10 variables:
    ##  $ manufacturer's name         : chr  "audi" "audi" "audi" "audi" ...
    ##  $ vehicle model               : chr  "a4" "a4" "a4" "a4" ...
    ##  $ Engine Displacement         : num  1.8 1.8 2 2 2.8 2.8 3.1 1.8 1.8 2 ...
    ##  $ YEAR                        : num  1999 1999 2008 2008 1999 ...
    ##  $ # of cylinders              : num  4 4 4 4 6 6 6 4 4 4 ...
    ##  $ transmission type           : chr  "auto(l5)" "manual(m5)" "manual(m6)" "auto(av)" ...
    ##  $ drivetrain type             : chr  "f" "f" "f" "f" ...
    ##  $ city fuel efficiency (mpg)  : num  18 21 20 21 16 18 18 18 16 20 ...
    ##  $ highway fuel efficency (mpg): num  29 29 31 30 26 26 27 26 25 28 ...
    ##  $ vehicle class               : chr  "compact" "compact" "compact" "compact" ...
    ##  - attr(*, "spec")=
    ##   .. cols(
    ##   ..   `manufacturer's name` = col_character(),
    ##   ..   `vehicle model` = col_character(),
    ##   ..   `Engine Displacement` = col_double(),
    ##   ..   YEAR = col_double(),
    ##   ..   `# of cylinders` = col_double(),
    ##   ..   `transmission type` = col_character(),
    ##   ..   `drivetrain type` = col_character(),
    ##   ..   `city fuel efficiency (mpg)` = col_double(),
    ##   ..   `highway fuel efficency (mpg)` = col_double(),
    ##   ..   `vehicle class` = col_character()
    ##   .. )

What issues do we see with these data?

Now, it is your turn\! Explore the `starwars` data and identify
    issues:

``` r
str(starwars)
```

    ## Classes 'spec_tbl_df', 'tbl_df', 'tbl' and 'data.frame': 87 obs. of  10 variables:
    ##  $ character name: chr  "Luke Skywalker" "C-3PO" "R2-D2" "Darth Vader" ...
    ##  $ HEIGHT        : num  172 167 96 202 150 178 165 97 183 182 ...
    ##  $ MASS          : num  77 75 32 136 49 120 75 32 84 77 ...
    ##  $ hair color    : chr  "blond" NA NA "none" ...
    ##  $ skin color    : chr  "fair" "gold" "white, blue" "white" ...
    ##  $ eye color     : chr  "blue" "yellow" "red" "yellow" ...
    ##  $ year of bith  : num  19 112 33 41.9 19 52 47 NA 24 57 ...
    ##  $ gender        : chr  "male" NA NA "male" ...
    ##  $ homeworld     : chr  "Tatooine" "Tatooine" "Naboo" "Tatooine" ...
    ##  $ species       : chr  "Human" "Droid" "Droid" "Human" ...
    ##  - attr(*, "spec")=
    ##   .. cols(
    ##   ..   `character name` = col_character(),
    ##   ..   HEIGHT = col_double(),
    ##   ..   MASS = col_double(),
    ##   ..   `hair color` = col_character(),
    ##   ..   `skin color` = col_character(),
    ##   ..   `eye color` = col_character(),
    ##   ..   `year of bith` = col_double(),
    ##   ..   gender = col_character(),
    ##   ..   homeworld = col_character(),
    ##   ..   species = col_character()
    ##   .. )

## Fixing Variable Names

### With `janitor`

One of the issues with both data sets are the variable names. If you
have a data set with a large number of columns that you’ll want to
retain, but many of which need to be renamed, the `janitor` package’s
`clean_names()` function can help jumpstart the process.

The `case` argument is particularly important here. The default is `case
= snake`: \* “snake” produces snake\_case

There are several other options though: \* “lower\_camel” or
“small\_camel” produces lowerCamel \* “upper\_camel” or “big\_camel”
produces UpperCamel \* “screaming\_snake” or “all\_caps” produces
ALL\_CAPS \* “lower\_upper” produces lowerUPPER \* “upper\_lower”
produces UPPERlower

We’ll try out `clean_names()` on the `mpg` data:

``` r
mpg %>%
  clean_names() -> mpg_1_names
```

This is a *pipeline*. We can read it like a paragraph, inserting the
word *then* every time we see the pipe operator (`%>%`):

1.  First, we take the `mpg` data, *then*
2.  we clean its names, *then*
3.  we save the output to `mpg_1_names`.

We use pipelines to make our code easier to read.

Now, back to renaming variables\! We can specify a different case using:

``` r
mpg %>%
  clean_names(case = "lower_camel") -> mpg_1_names
```

Now, you try with the `starwars` data. Use whatever format you’d like,
and save your output to `starwars_1_names`\!

``` r
starwars %>%
  clean_names(case = "lower_camel") -> starwars_1_names
```

### With `dplyr`

We now have standardized variable names without special characters, but
many are too long for easy use. We can use `dplyr`’s `rename()` function
to modify these names manually:

``` r
mpg_1_names %>%
  rename(
    mfr = manufacturersName,
    model = vehicleModel,
    hwy = highwayFuelEfficencyMpg
  ) -> mpg_2_names
```

Now, you try on the `starwars_1_names` data. Rename `characterName`,
`yearOfBith` and `homeworld`:

``` r
starwars_1_names %>%
  rename(
    name = characterName,
    birthYear = yearOfBith,
    planet = homeworld
  ) -> starwars_2_names
```

## Selecting Columns

### Subsetting

We often only want a selection of columns from our data. We can use the
`select()` function from `dplyr` to help get us a subset of our data.

``` r
mpg_2_names %>%
  select(mfr, model, hwy) -> mpg_3_subset
```

Now, you try - subset the `starwars_2_names` data so that we only have
name, birth year, and planet:

``` r
starwars_2_names %>%
  select(name, birthYear, planet) -> starwars_3_subset
```

### Re-ordering

We can also use `select()` to re-order columns:

``` r
mpg_3_subset %>%
  select(hwy, mfr, model) -> mpg_4_subset
```

If we have a lot of column names, this can be cumbersome. Luckily, the
`everything()` function from `dplyr()` can be used to make life easier:

``` r
mpg_3_subset %>%
  select(hwy, everything()) -> mpg_4_subset
```

Now, you try re-ordering the columns in `starwars_3_subset`. Save the
outcome in `starwars_4_subset`:

``` r
starwars_3_subset %>%
  select(planet, everything()) -> starwars_4_subset
```

## More on Pipelines

As you can see, we’ve made a number of what are known as “intermediary”
data objects - they capture specific changes to our data as we proceed
through the data cleaning process. These sometimes can be helpful when
you are learning how to code and clean data, but ultimately they can
create confusion and are unncessary. We can simplify all of the code we
have written into a single pipeline:

``` r
read_csv(here("data", "mpg_messy.csv")) %>%
  clean_names(case = "lower_camel") %>%
  rename(
    mfr = manufacturersName,
    model = vehicleModel,
    hwy = highwayFuelEfficencyMpg
  ) %>%
  select(mfr, model, hwy) -> mpgClean
```

    ## Parsed with column specification:
    ## cols(
    ##   `manufacturer's name` = col_character(),
    ##   `vehicle model` = col_character(),
    ##   `Engine Displacement` = col_double(),
    ##   YEAR = col_double(),
    ##   `# of cylinders` = col_double(),
    ##   `transmission type` = col_character(),
    ##   `drivetrain type` = col_character(),
    ##   `city fuel efficiency (mpg)` = col_double(),
    ##   `highway fuel efficency (mpg)` = col_double(),
    ##   `vehicle class` = col_character()
    ## )

This is more compact (less opportunity for typos\!) and far easier to
read:

1.  First, we import the `mpg_messy.csv` data, *then*
2.  we convert all of the column names to lowerCamel, *then*
3.  we rename several variables further, *then*
4.  we subset based on column, *then*
5.  we store the results in a new object named `mpgClean`.

Now, you try condensing all of the starwars code into a single pipeline:

``` r
read_csv(here("data", "starwars_messy.csv")) %>%
  clean_names(case = "lower_camel") %>%
  rename(
    name = characterName,
    birthYear = yearOfBith,
    planet = homeworld
  ) %>%
  select(planet, everything()) -> starwarsClean
```

    ## Parsed with column specification:
    ## cols(
    ##   `character name` = col_character(),
    ##   HEIGHT = col_double(),
    ##   MASS = col_double(),
    ##   `hair color` = col_character(),
    ##   `skin color` = col_character(),
    ##   `eye color` = col_character(),
    ##   `year of bith` = col_double(),
    ##   gender = col_character(),
    ##   homeworld = col_character(),
    ##   species = col_character()
    ## )
