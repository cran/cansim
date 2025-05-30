% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/cansim_sql.R
\name{get_cansim_sqlite}
\alias{get_cansim_sqlite}
\title{Retrieve a Statistics Canada data table using NDM catalogue number as SQLite database connection}
\usage{
get_cansim_sqlite(
  cansimTableNumber,
  language = "english",
  refresh = FALSE,
  auto_refresh = FALSE,
  timeout = 1000,
  cache_path = getOption("cansim.cache_path")
)
}
\arguments{
\item{cansimTableNumber}{the NDM table number to load}

\item{language}{\code{"en"} or \code{"english"} for English and \code{"fr"} or \code{"french"} for French language versions (defaults to English)}

\item{refresh}{(Optional) When set to \code{TRUE}, forces a reload of data table (default is \code{FALSE})}

\item{auto_refresh}{(Optional) When set to \code{TRUE}, it will reload of data table if a new version is available (default is \code{FALSE})}

\item{timeout}{(Optional) Timeout in seconds for downloading cansim table to work around scenarios where StatCan servers drop the network connection.}

\item{cache_path}{(Optional) Path to where to cache the table permanently. By default, the data is cached
in the path specified by `getOption("cansim.cache_path")`, if this is set. Otherwise it will use `tempdir()`.}
}
\value{
A database connection to a local SQLite database with the StatCan Table data.
}
\description{
Retrieves a data table using an NDM catalogue number as an SQLite table. Retrieved table data is
cached permanently if a cache path is supplied or for duration of the current R session.
The function will check against the latest release data for the table and emit a warning message
if the cached table is out of date.
}
\examples{
\dontrun{
con <- get_cansim_connection("34-10-0013", format="sqlite")

# Work with the data connection
gplimpse(con)

disconnect_cansim_sqlite(con)
}
}
\keyword{internal}
