#' Get Vessel History
#'
#' @param vesselname Vessel Name
#' @param start_date Start date of history window
#' @param end_date End date of history window
#'
#' @return Tibble of historical vessel trip information
#' @export
#'
#' @examples
#' get_vesselhistory("Yakima", "2024-07-01", "2024-07-02")
get_vesselhistory <- function(vesselname, start_date, end_date) {

  cat(glue::glue("Getting vessel history for {vesselname}..."))
  vesselhistory <- httr2::request("https://www.wsdot.wa.gov/Ferries/API/Vessels/rest") |>
    httr2::req_url_path_append("vesselhistory") |>
    httr2::req_url_path_append(URLencode(vesselname)) |>
    httr2::req_url_path_append(start_date) |>
    httr2::req_url_path_append(end_date) |>
    httr2::req_url_query(apiaccesscode = Sys.getenv("WSDOT_ACCESS_CODE")) |>
    httr2::req_perform() |>
    httr2::resp_body_string() |>
    jsonlite::fromJSON() |>
    tibble::as_tibble()

  cat(glue::glue("\t{nrow(vesselhistory)} records retrieved for {vesselname}"),"\n")
  vesselhistory
}
