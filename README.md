
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rreversegeocoder

<!-- badges: start -->

<!-- badges: end -->

The goal of rreversegeocoder is to, given latitude and longitude, find
the nearest city in US.

Why? We get new features for feature engineering that can improve the
performance of machine learning models.

## Installation

You can install the development version of rreversegeocoder from
[GitHub](https://github.com/jrosell/rreversegeocoder) with:

``` r
pak::pak("jrosell/rreversegeocoder")
```

## Example

This is a basic example which shows you how to get all the geoname
information from a given latitude and longitude in US:

``` r
library(tidyverse)
library(tidymodels)
library(rreversegeocoder)

cites <- download_cities_with_population_5000()

input <- tribble(
    ~latitude, ~longitude,
    34.6, -120,
    34.1, -100
)

output <- input |>
    bind_cols(reverse_geocoder_us_cities_with_population_5000(input)) |>
    left_join(cites, by = "geonameid")

glimpse(output)
```

<pre>
Rows: 2
Columns: 21
$ latitude          <dbl> 34.6, 34.1
$ longitude         <dbl> -120, -100
$ geonameid         <chr> "5397059", "4739078"
$ name              <chr> "Solvang", "Vernon"
$ asciiname         <chr> "Solvang", "Vernon"
$ alternatenames    <chr> "Solvang,Solvang i California,Solvanq,Solveng,solbhya…
$ geoname_latitude  <dbl> 34.59582, 34.15536
$ geoname_longitude <dbl> -120.13765, -99.26628
$ feature_class     <chr> "P", "P"
$ feature           <chr> "PPL", "PPLA2"
$ country           <chr> "US", "US"
$ cc2               <chr> NA, NA
$ admin1            <chr> "CA", "TX"
$ admin2            <chr> "083", "487"
$ admin3            <chr> NA, NA
$ admin4            <chr> NA, NA
$ population        <dbl> 5741, 10573
$ elevation         <dbl> 154, 361
$ dem               <dbl> 152, 361
$ timezone          <chr> "America/Los_Angeles", "America/Chicago"
$ mdate             <date> 2017-03-09, 2017-03-09
</pre>
