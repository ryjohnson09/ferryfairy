#' Convert Timestamp
#'
#' @description
#' The Seattle Ferry data contains many timestamps in the following
#' format: "/Date(1716553800000-0700)/". This function will convert
#' the timestamp into a readable date, time, timezone POSIXt object.
#'
#' @param timestamp The timestamp as a string.
#'
#' @return POSIXt human readable time stamp
#' @export
#'
#' @examples
#' convert_timestamp("/Date(1716553800000-0700)/")
convert_timestamp <- function(timestamp) {

  # Define timestamp and timezone offset
  timestamp_ms <- as.numeric(stringr::str_extract(timestamp, "(?<=/Date\\()\\d+(?=[-+])"))

  # Convert the timestamp to seconds
  timestamp_sec <- timestamp_ms / 1000

  # Convert to datetime object
  as.POSIXct(timestamp_sec, origin = "1970-01-01", tz = "US/Pacific")
}
