#' Vessel Accommodations
#'
#' @description
#' A wrapper to extract various information about a specific vessel.
#'
#' @param VesselID Numeric ID for a specific vessel. If blank, all vessel information will be returned.
#' @param apiaccesscode WSDOT Access Code.
#'
#' @return Vessel information organized as a list.
#' @export
#'
#' @examples
#' vessel_accommodations(38)
vessel_accommodations <- function(VesselID = NULL, apiaccesscode = Sys.getenv("WSDOT_ACCESS_CODE")) {

  # If VesselID is provided
  if (is.null(VesselID)) {
    endpoint = "http://www.wsdot.wa.gov/Ferries/API/Vessels/rest/vesselaccommodations"
  } else {
    endpoint = paste0("http://www.wsdot.wa.gov/Ferries/API/Vessels/rest/vesselaccommodations", "/", VesselID)
  }

  # Make Request
  httr2::request(endpoint) |>
    httr2::req_url_query(apiaccesscode = apiaccesscode) |>
    httr2::req_perform() |>
    httr2::resp_body_json()
}
