% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_vesselhistory.R
\name{get_vesselhistory}
\alias{get_vesselhistory}
\title{Get Vessel History}
\usage{
get_vesselhistory(vesselname, start_date, end_date)
}
\arguments{
\item{vesselname}{Vessel Name}

\item{start_date}{Start date of history window}

\item{end_date}{End date of history window}
}
\value{
Tibble of historical vessel trip information
}
\description{
Get Vessel History
}
\examples{
get_vesselhistory("Yakima", "2024-07-01", "2024-07-02")
}
