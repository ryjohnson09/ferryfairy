#' Clean vesselinfo_raw data
#'
#' @description
#' This function cleans the `vesselinfo_raw data`
#'
#' @param vesselinfo_raw
#'
#' @return a tibble of cleaned data
#' @export
#'
#' @examples
#' clean_vesselinfo(vesselinfo_raw)
clean_vesselinfo <- function(vesselinfo_raw) {
  vesselinfo_raw |>
    # select columns of interest for modeling or summary info
    select(vessel_name,
           max_passenger_count,
           reg_deck_space,
           vessel_name_desc,
           vessel_history,
           drawing_img,
           silhouette_img) |>
    # vessel_names to lowercase
    mutate(vessel_name = tolower(vessel_name))

}
