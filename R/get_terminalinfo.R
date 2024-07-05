#' Get Terminal Information
#'
#' @description
#' A helper function to extract the name, ID, latitude, and longitude for
#' the various Seattle Ferry stations
#'
#' @return A tibble.
#' @export
#'
#' @examples
#' get_terminalinfo()
get_terminalinfo <- function() {

  base_url <- "https://www.wsdot.wa.gov"

  terminallocations_ep <- "ferries/api/terminals/rest/terminallocations"

  httr2::request(base_url) |>
    httr2::req_url_query(apiaccesscode = Sys.getenv("WSDOT_ACCESS_CODE")) |>
    httr2::req_url_path_append(terminallocations_ep) |>
    httr2::req_perform() |>
    httr2::resp_body_string() |>
    jsonlite::fromJSON() |>
    tibble::as_tibble() |>
    dplyr::select(TerminalID, TerminalName, Latitude, Longitude) |>
    janitor::clean_names()
}
