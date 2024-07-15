#' A wrapper around DBI::dbWriteTable that Write a data frame to the specified database and schema
#'
#' @param df input databframe
#' @param name the name of the table to be written to the database
#' @param con the database connection
#' @param schema schema, defaults to the value of the environment variable DATABASE_SCHEMA
#' @param append argument to dbWriteTable
#' @param overwrite argument to dbWriteTable
#'
#' @return
#' @export
#'
#' @examples
#' write_df_to_db(vesselhistory_raw, my_username, con, append = TRUE)
write_df_to_db <- function(df, name, con, schema = Sys.getenv("DATABASE_SCHEMA"), append = FALSE, overwrite = FALSE) {

  tablename <- paste0(deparse(substitute(df)), name)

  # print informational statement
  print(glue::glue("Writing df {tablename} to database schema {schema}..."),"\n")

  # Insert your start time stamp
  start_time <- Sys.time()

  DBI::dbWriteTable(conn = con, # the connection
                    name = DBI::Id(
                      schema=schema, # our database schema
                      name=my_df_name), # the name of the table you will create in the DB
                    value = df,
                    append = append,
                    overwrite = overwrite)

  # Insert your end time stamp
  end_time <- Sys.time()
  duration <- end_time - start_time

  print(glue::glue("ℹ️ Info: Writing {tablename} to database took",
                   round(duration[[1]], 2),  units(duration)))

}
