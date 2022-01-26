Data Wrangling in R, Lesson 1
================
Christopher Prener, Ph.D.
(January 26, 2022)

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
```

    ## 
    ## Attaching package: 'janitor'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     chisq.test, fisher.test

``` r
# manage file paths
library(here)      # manage file paths
```

    ## here() starts at /Users/prenercg/GitHub/slu-dss/wrangling-01

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
`read_csv()` function. **This is different from `utils::read.csv()`!**

``` r
mpg <- read_csv(here("data", "mpg_messy.csv"))
```

    ## Rows: 234 Columns: 10

    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr (5): manufacturer's name, vehicle model, transmission type, drivetrain t...
    ## dbl (5): Engine Displacement, YEAR, # of cylinders, city fuel efficiency (mp...

    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

Now, you try the same syntax out - import the `starwars_messy.csv` data
from the same source:

## Quickly Exploring Data

To quickly explore the `mpg` data, we’ll take a look at both the column
names and some sample values using `utils::str()`:

``` r
str(mpg)
```

    ## spec_tbl_df [234 × 10] (S3: spec_tbl_df/tbl_df/tbl/data.frame)
    ##  $ manufacturer's name         : chr [1:234] "audi" "audi" "audi" "audi" ...
    ##  $ vehicle model               : chr [1:234] "a4" "a4" "a4" "a4" ...
    ##  $ Engine Displacement         : num [1:234] 1.8 1.8 2 2 2.8 2.8 3.1 1.8 1.8 2 ...
    ##  $ YEAR                        : num [1:234] 1999 1999 2008 2008 1999 ...
    ##  $ # of cylinders              : num [1:234] 4 4 4 4 6 6 6 4 4 4 ...
    ##  $ transmission type           : chr [1:234] "auto(l5)" "manual(m5)" "manual(m6)" "auto(av)" ...
    ##  $ drivetrain type             : chr [1:234] "f" "f" "f" "f" ...
    ##  $ city fuel efficiency (mpg)  : num [1:234] 18 21 20 21 16 18 18 18 16 20 ...
    ##  $ highway fuel efficency (mpg): num [1:234] 29 29 31 30 26 26 27 26 25 28 ...
    ##  $ vehicle class               : chr [1:234] "compact" "compact" "compact" "compact" ...
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
    ##  - attr(*, "problems")=<externalptr>

What issues do we see with these data?

Now, it is your turn! Explore the `starwars` data and identify issues:

## Fixing Variable Names

### With `janitor`

One of the issues with both data sets are the variable names. If you
have a data set with a large number of columns that you’ll want to
retain, but many of which need to be renamed, the `janitor` package’s
`clean_names()` function can help jump start the process.

The `case` argument is particularly important here. The default is
`case = snake`: \* “snake” produces snake_case

There are several other options though: \* “lower_camel” or
“small_camel” produces lowerCamel \* “upper_camel” or “big_camel”
produces UpperCamel \* “screaming_snake” or “all_caps” produces ALL_CAPS
\* “lower_upper” produces lowerUPPER \* “upper_lower” produces
UPPERlower

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

Now, back to renaming variables! We can specify a different case using:

``` r
mpg %>%
  clean_names(case = "lower_camel") -> mpg_1_names
```

Now, you try with the `starwars` data. Use whatever format you’d like,
and save your output to `starwars_1_names`!

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

## Selecting Columns

### Sub-setting

We often only want a selection of columns from our data. We can use the
`select()` function from `dplyr` to help get us a subset of our data.

``` r
mpg_2_names %>%
  select(mfr, model, hwy) -> mpg_3_subset
```

Now, you try - subset the `starwars_2_names` data so that we only have
name, birth year, and planet:

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

### Removing Variables

We can also use `select()` to remove variables from a data frame. We
won’t assign these changes to an object this time:

``` r
mpg_4_subset %>%
  select(-hwy)
```

    ## # A tibble: 234 × 2
    ##    mfr   model     
    ##    <chr> <chr>     
    ##  1 audi  a4        
    ##  2 audi  a4        
    ##  3 audi  a4        
    ##  4 audi  a4        
    ##  5 audi  a4        
    ##  6 audi  a4        
    ##  7 audi  a4        
    ##  8 audi  a4 quattro
    ##  9 audi  a4 quattro
    ## 10 audi  a4 quattro
    ## # … with 224 more rows

You try the same with the `starwars_4_subset` data by removing the bith
year data. Again, no need to assign the changes to an object.

## More on Pipelines

As you can see, we’ve made a number of what are known as “intermediary”
data objects - they capture specific changes to our data as we proceed
through the data cleaning process. These sometimes can be helpful when
you are learning how to code and clean data, but ultimately they can
create confusion and are unnecessary. We can simplify all of the code we
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

    ## Rows: 234 Columns: 10

    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr (5): manufacturer's name, vehicle model, transmission type, drivetrain t...
    ## dbl (5): Engine Displacement, YEAR, # of cylinders, city fuel efficiency (mp...

    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

This is more compact (less opportunity for typos!) and far easier to
read:

1.  First, we import the `mpg_messy.csv` data, *then*
2.  we convert all of the column names to lowerCamel, *then*
3.  we rename several variables further, *then*
4.  we subset based on column, *then*
5.  we store the results in a new object named `mpgClean`.

Now, you try condensing all of the starwars code into a single pipeline:
