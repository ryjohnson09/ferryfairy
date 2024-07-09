#' Clean vesselhistory_raw data
#'
#' @description
#' This function cleans the vesselhistory_raw data.
#'
#' @param vesselhistory_raw
#'
#' @return a tibble of cleaned vesselhistory data
#' @export
#'
#' @examples
#' clean_vesselhistory(vesselhistory_raw)
clean_vesselhistory <- function(vesselhistory_raw) {
  vesselhistory_raw |>
    # remove any duplicates, which may occur because we are appending data each write
    distinct() |>
    # drop vessel_id, an unreliable value
    select(-vessel_id) |>
    # convert character date to datetimes
    mutate_at(c("scheduled_depart", "actual_depart", "est_arrival", "date"), convert_timestamp) |>
    # convert date column to a `date` format rather than a datetime
    mutate(date = as_date(date)) |>
    # change vessel, departing, and arriving to lowercase
    mutate(across(c(vessel, departing, arriving), ~ tolower(.x))) |>
    # remove spaces
    mutate(across(c(vessel, departing, arriving), ~ str_replace_all(.x, " ","_"))) |>
    # calculate delay in departure (minutes)
    mutate(delay = as.numeric(difftime(actual_depart,scheduled_depart, units="mins"))) |>
    # rename some terminals to more familiar names to match with weather data
    mutate(across(c(departing, arriving), ~ case_when(
      .x == "bainbridge" ~ "bainbridge_island",
      .x == "colman" ~ "seattle",
      .x == "keystone" ~ "coupeville",
      .x == "lopez" ~ "lopez_island",
      .x == "orcas" ~ "orcas_island",
      .x == "pt._defiance" ~ "point_defiance",
      .x == "shaw" ~ "shaw_island",
      .x == "vashon" ~ "vashon_island",
      .default = .x
    ))) |>
    # Make a route column
    mutate(route = str_c(departing,arriving, sep = "-")) |>
    # add a route identifier so out and back routes can be grouped in summary tables
    rowwise() |>
    mutate(pair = list(c(departing, arriving))) |>
    ungroup() |>
    mutate(sorted = map(pair, str_sort)) |>
    mutate(sorted_pair = map_chr(sorted, str_c, collapse = "-")) |>
    group_by(sorted_pair) |>
    mutate(route_id = cur_group_id()) |>
    ungroup() |>
    select(-pair, -sorted, -sorted_pair)
}
