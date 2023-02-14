#' Download cities with population 5000
#'
#' Download cities with population 5000 information from geonames.
#'
#' @rdname download_cities_with_population_5000
#'
#' @details It returns a tibble with all the data
#'
#' @examples
#' download_cities_with_population_5000()
#'
#' @seealso <https://github.com/jrosell/rreversegeocoder/blob/main/R/cities.R>
#' @export

download_cities_with_population_5000 <- function() {
    n <- 5000
    download_dir <- tempdir()
    utils::download.file(
        paste0("https://download.geonames.org/export/dump/cities",n,".zip"),
        destfile = paste0(download_dir, "/cities",n,".zip")
    )
    utils::unzip(paste0(download_dir, "/cities",n,".zip"), exdir = download_dir)
    columns = c(
        "geonameid",         # integer id of record in geonames database
        "name",              # name of geographical point (utf8) varchar(200)
        "asciiname",         # name of geographical point in plain ascii characters, varchar(200)
        "alternatenames",    # alternatenames, comma separated, ascii names automatically transliterated, convenience attribute from alternatename table, varchar(10000)
        "latitude",          # latitude in decimal degrees (wgs84)
        "longitude",         # longitude in decimal degrees (wgs84)
        "feature_class",     # see http://www.geonames.org/export/codes.html, char(1)
        "feature",           # see http://www.geonames.org/export/codes.html, varchar(10)
        "country",           # ISO-3166 2-letter country code, 2 characters
        "cc2",               # alternate country codes, comma separated, ISO-3166 2-letter country code, 200 characters
        "admin1",            # fipscode (subject to change to iso code), see exceptions below, see file admin1Codes.txt for display names of this code; varchar(20)
        "admin2",            # code for the second administrative division, a county in the US, see file admin2Codes.txt; varchar(80)
        "admin3",            # code for third level administrative division, varchar(20)
        "admin4",            # code for fourth level administrative division, varchar(20)
        "population",        # bigint (8 byte int)
        "elevation",         # in meters, integer
        "dem",               # digital elevation model, srtm3 or gtopo30, average elevation of 3''x3'' (ca 90mx90m) or 30''x30'' (ca 900mx900m) area in meters, integer. srtm processed by cgiar/ciat.
        "timezone",          # the iana timezone id (see file timeZone.txt) varchar(40)
        "mdate"             # date of last modification in yyyy-MM-dd format
    )
    cities_data <- paste0(download_dir, "/cities",n,".txt") |>
        readr::read_tsv(col_names = columns, guess_max = 20000, show_col_types = FALSE) |>
        dplyr::mutate(dplyr::across("geonameid", as.character)) |>
        dplyr::rename(
            geoname_latitude = latitude,
            geoname_longitude = longitude
        )
    return(cities_data)
}
