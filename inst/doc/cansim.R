## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
	collapse = TRUE,
	comment = "#>",
	eval = nzchar(Sys.getenv("COMPILE_VIG"))
)
library(cansim)

## ---- eval = FALSE------------------------------------------------------------
#  install.packages("cansim")

## ----load_package_cran, echo=TRUE, message=FALSE, warning=FALSE, eval = FALSE----
#  # install.packages("remotes")
#  remotes::install_github("mountainmath/cansim")
#  
#  library(cansim)

## -----------------------------------------------------------------------------
data <- get_cansim("14-10-0293")
head(data)

## -----------------------------------------------------------------------------
get_cansim_table_overview("14-10-0293")

## -----------------------------------------------------------------------------
search_cansim_cubes("housing price indexes")

## -----------------------------------------------------------------------------
get_cansim_vector(c("Metro Van Apartment Construction Price Index"="v44176267",
                    "Metro Van CPI"="v41692930"),
                  start_time = "2015-05-01",
                  end_time="2015-08-01")

