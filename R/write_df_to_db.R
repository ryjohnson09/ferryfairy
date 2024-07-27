#' A wrapper around DBI::dbWriteTable that writes a data frame to the specified database and schema
#'
#' @param df input databframe
#' @param name the name of the table to be written to the database
#' @param con the database connection
#' @param append argument to dbWriteTable
#' @param overwrite argument to dbWriteTable
#'
#' @return a confirmation statement
#' @export
#'
#' @examples
#' write_df_to_db(vesselhistory_raw, my_username, con, append = TRUE)
write_df_to_db <- function(df, name, con, append = FALSE, overwrite = FALSE) {

  # print informational statement
  print(glue::glue("Writing df {name} to database schema {schema}..."),"\n")

  # Insert your start time stamp
  start_time <- Sys.time()

  DBI::dbWriteTable(conn = con, # the connection
                    name = name, # the name of the table you will create in the DB
                    value = df,
                    append = append,
                    overwrite = overwrite)

  # Insert your end time stamp
  end_time <- Sys.time()
  duration <- end_time - start_time

  print(glue::glue("ℹ️ Info: Writing {name} to database took ",
                   round(duration[[1]], 2),  units(duration)))

}

