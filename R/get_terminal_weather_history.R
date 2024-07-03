#' Get Terminal Weather History
#'
#' @param terminal Seattle ferry terminal name.
#' @param start_date Start date of history window.
#' @param end_date End date of history window.
#' @param pause pause is specified in number of seconds. Inject a delay if the API rejects requests for too many at once. One year of data for one location is equivalent to about 16 API calls and there is a limit of 600 per minute so for 20 terminals, add a pause.
#'
#' @return Tibble where each row is a terminal and weather information on a specific date.
#' @export
#'
#' @examples
#' get_terminal_weather_history("Anacortes", start_date = "2024-06-01", end_date = "2024-06-03", pause = 0)
get_terminal_weather_history <- function(terminal, start_date, end_date, pause=0) {

  # Get Terminal Locations
  base_url <- "https://www.wsdot.wa.gov"
  terminallocations_ep <- "ferries/api/terminals/rest/terminallocations"

  req <- httr2::request(base_url) |>
    httr2::req_url_query(apiaccesscode = Sys.getenv("WSDOT_ACCESS_CODE"))

  terminallocations_raw <- req |>
    httr2::req_url_path_append(terminallocations_ep) |>
    httr2::req_perform() |>
    httr2::resp_body_string() |>
    jsonlite::fromJSON() |>
    tibble::as_tibble()

  terminallocations <- terminallocations_raw |>
    dplyr::select(TerminalID, TerminalName, Latitude, Longitude) |>
    janitor::clean_names()


  # Extract terminal lat and long
  lat <- terminallocations |>
    dplyr::filter(terminal_name == terminal) |>
    dplyr::pull(latitude)

  long <- terminallocations |>
    dplyr::filter(terminal_name == terminal) |>
    dplyr::pull(longitude)

  print(glue::glue("Getting weather history for {terminal} terminal..."))

  # Query weather API
  req <- httr2::request("https://archive-api.open-meteo.com/v1/archive") |>
    httr2::req_url_query(latitude=lat, longitude=long,
                  start_date=start_date, end_date=end_date,
                  hourly=c("precipitation","weather_code","cloud_cover_low",
                           "wind_speed_10m","wind_gusts_10m"),
                  wind_speed_unit="mph",
                  precipitation_unit="inch",
                  timezone="US/Pacific",
                  .multi = "comma")

  resp <- req |>
    httr2::req_perform() |>
    httr2::resp_body_string() |>
    jsonlite::fromJSON() |>
    tibble::as_tibble()

  hourly_data <- dplyr::bind_cols(
    terminal=terminal,
    lat=resp$latitude[1],
    long=resp$longitude[1],
    resp$hourly)

  print(glue::glue("\t{nrow(hourly_data)} records retrieved for {terminal}"))

  Sys.sleep(pause)

  hourly_data

}
