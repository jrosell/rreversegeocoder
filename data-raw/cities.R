
rlang::check_installed(c("tidyverse", "tidymodels", "rreversegeocoder", "tictoc"))

library(tidyverse)
library(tidymodels)
library(rreversegeocoder)

cities <- download_cities_with_population_5000() %>%
    select(geonameid, geoname_latitude, geoname_longitude, name, admin1, admin2, country) |> 
    rename(latitude = geoname_latitude, longitude = geoname_longitude)
cities %>% glimpse()
cities %>% count(country)

us_cities_with_population_5000 <- cities %>%
    filter(country == "US") %>%
    select(geonameid, latitude, longitude)
us_cities_with_population_5000 %>% glimpse()


tictoc::tic("train kknn model for cities")
us_cities_with_population_5000_fit <- us_cities_with_population_5000 %>%
    recipe(geonameid ~ latitude + longitude) %>%
    workflow(nearest_neighbor(engine = "kknn", mode = "classification", neighbors = 1)) %>%
    fit(us_cities_with_population_5000)
tictoc::toc()


usethis::use_data(us_cities_with_population_5000_fit, overwrite = TRUE, internal = TRUE)

# example_data <- here::here("data-raw", "kaggle-example-s3s1.csv") %>%
#     read_csv(show_col_types = FALSE)
#
# tictoc::tic("infer geonameid for s3s1")
# result <- example_data %>%
#     transmute(latitude = Latitude, longitude = Longitude) %>%
#     predict(cities_fit, .) %>%
#     bind_cols(example_data, .) %>%
#     rename(geonameid = .pred_class)
# result
# tictoc::toc()
#
# result %>%
#      left_join(cities,  by = "geonameid") %>%
#      glimpse()
