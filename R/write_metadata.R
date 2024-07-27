#' Write YAML metadata to facilitate conditional Quarto rendering
#'
#' @description
#' This function writes dynamically-generated YAML in a Quarto document of the form:
#' ---
#' key: value
#' ---
#' It is used in conjunction with the Quarto chunk option `.content-visible when-meta` or `.content-hidden when-meta`
#'
#'
#' @param key A string representing the metadata key
#' @param value The metadata value. When used in conjunction with the Quarto chunk option `.content-visible when-meta` or `.content-hidden when-meta`, this should be a boolean TRUE or FALSE
#'
#' @return asis knitr output
#' @export
#'
#' @examples
#' write_meta("condition_1", TRUE)

write_metadata <- function(key, value) {

  # create empty list
  metadata_list <- list()
  # add key value pair to list
  metadata_list[[key]] <- value

  handlers <- list(logical = function(x) {
    value <- ifelse(x, "true", "false")
    structure(value, class = "verbatim")
  })
  res <- yaml::as.yaml(metadata_list, handlers = handlers)
  knitr::asis_output(paste0("---\n", res, "---\n"))
}
