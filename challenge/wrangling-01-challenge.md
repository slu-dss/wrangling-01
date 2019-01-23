Data Wrangling in R, Lesson 1 Challenge
================
(January 23, 2019)

## Introduction

This is the challenge notebook for the first data wrangling lesson. Test
the skills that you picked up today by cleaning hurricane data from
`dplyr`. We’ve filled in the dependencies section - the rest is up to
you\!

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

## Cleaning Data

In a single pipeline, you should:

1.  Read the data from `data/storms_messy.csv` into `R`
2.  Clean all of the very messy variable names
3.  Remove the latitude and longitude variables altoghether
4.  Further clean up the names of the storm name (there is a typo\!),
    saffir simpson category, status, wind, and pressure variables
