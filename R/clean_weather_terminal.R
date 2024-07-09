#' Clean weather_terminal_history_raw Data
#'
#' @description
#' This function cleans the `weather_terminal_history_raw data`
#' .
#' @param weather_terminal_history_raw
#'
#' @return a tibble of cleaned data
#' @export
#'
#' @examples
#' clean_weather_terminal(weather_terminal_history_raw)
clean_weather_terminal <- function(weather_terminal_history_raw) {
  weather_terminal_history_raw |>
    # remove any duplicates, which may occur because we are appending data each write
    distinct() |>
    # change time to datetime
    mutate(time = ymd_hm(time, tz = "US/Pacific")) |>
    # change terminal to lowercase, remove spaces
    mutate(terminal = tolower(terminal),
           terminal = str_trim(terminal),
           terminal = str_replace_all(terminal, " ","_")) |>
    # convert to tibble for nicer viewing
    as_tibble()
}
