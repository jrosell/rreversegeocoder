#' Reverse geocoder
#'
#' Given latitude and longitude, find the nearest city in US with population 5000.
#'
#' @rdname reverse_geocoder_us_cities_with_population_5000
#' @param df A data.frame or tibble with the first two columns latitude and longitude
#'
#' @details It returns the nearest geonameid from geonames.
#'
#' @examples
#' reverse_geocoder_us_cities_with_population_5000(data.frame(34.6, -120))
#'
#' @seealso <https://github.com/jrosell/rreversegeocoder/blob/main/R/reverse_geocoder.R>
#' @export
reverse_geocoder_us_cities_with_population_5000 <- function(df) {
    df <- dplyr::rename(df, latitude = 1, longitude = 2)
    suppressPackageStartupMessages(requireNamespace("workflows"))
    us_cities_with_population_5000_fit |>
        predict(df) |>
        dplyr::transmute(geonameid = .pred_class)
}
