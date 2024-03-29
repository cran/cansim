% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/cansim.R
\name{get_cansim_table_url}
\alias{get_cansim_table_url}
\title{Retrieve a Statistics Canada data table URL given a table number}
\usage{
get_cansim_table_url(cansimTableNumber, language = "en")
}
\arguments{
\item{cansimTableNumber}{the NDM table number to load}

\item{language}{\code{"en"} or \code{"english"} for English and \code{"fr"} or \code{"french"} for French language versions (defaults to English)}
}
\value{
String object containing URL for specified table number
}
\description{
Retrieve URL of a table from the API given a table number. Offers a more stable approach than manually guessing the URL of the table.
}
\examples{
\dontrun{
get_cansim_table_url("34-10-0013")
get_cansim_table_url("34-10-0013", language = "fr")
}
}
