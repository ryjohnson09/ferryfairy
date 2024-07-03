#' Get Vessel Info
#'
#' @param VesselID Vessel ID number. Leave blank to extract all vessel info.
#'
#' @return Tibble of vessel information.
#' @export
#'
#' @examples
#' get_vesselinfo()
#' get_vesselinfo(1)
get_vesselinfo <- function(VesselID = NULL) {

  # If VesselID is provided
  if (is.null(VesselID)) {
    endpoint = "http://www.wsdot.wa.gov/Ferries/API/Vessels/rest/vesselbasics"
  } else {
    endpoint = paste0("http://www.wsdot.wa.gov/Ferries/API/Vessels/rest/vesselbasics", "/", VesselID)
  }

  # Make Request
  httr2::request(endpoint) |>
    httr2::req_url_query(apiaccesscode = Sys.getenv("WSDOT_ACCESS_CODE")) |>
    httr2::req_perform() |>
    httr2::resp_body_string() |>
    jsonlite::fromJSON() |>
    tibble::as_tibble()
}
