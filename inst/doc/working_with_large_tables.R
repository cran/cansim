## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  eval = nzchar(Sys.getenv("COMPILE_VIG"))
)

## ----setup--------------------------------------------------------------------
library(dplyr, warn.conflicts = FALSE)
library(ggplot2)

library(cansim)

## -----------------------------------------------------------------------------
connection.parquet <- get_cansim_connection("20-10-0001") # format='parquet' is the default

glimpse(connection.parquet)

## -----------------------------------------------------------------------------
connection.feather <- get_cansim_connection("20-10-0001", format='feather')

glimpse(connection.feather)

## -----------------------------------------------------------------------------
connection.sqlite <- get_cansim_connection("20-10-0001", format='sqlite')

glimpse(connection.sqlite)

## -----------------------------------------------------------------------------
get_cansim_table_overview("20-10-0001")

## -----------------------------------------------------------------------------
data.parquet <- connection.parquet %>%
  filter(GEO=="Canada",
         `Seasonal adjustment`=="Unadjusted",
         Sales=="Units",
         `Origin of manufacture`=="Total, country of manufacture",
         `Vehicle type` %in% c("Passenger cars","Trucks")) %>%
  collect_and_normalize()

data.parquet %>% head()

## -----------------------------------------------------------------------------
data.feather <- connection.feather %>%
  filter(GEO=="Canada",
         `Seasonal adjustment`=="Unadjusted",
         Sales=="Units",
         `Origin of manufacture`=="Total, country of manufacture",
         `Vehicle type` %in% c("Passenger cars","Trucks")) %>%
  collect_and_normalize()

data.feather %>% head()

## -----------------------------------------------------------------------------
data.sqlite <- connection.sqlite %>%
  filter(GEO=="Canada",
         `Seasonal adjustment`=="Unadjusted",
         Sales=="Units",
         `Origin of manufacture`=="Total, country of manufacture",
         `Vehicle type` %in% c("Passenger cars","Trucks")) %>%
  collect_and_normalize()

data.sqlite %>% head()

## -----------------------------------------------------------------------------
data.memory <- get_cansim("20-10-0001") %>%
  filter(GEO=="Canada",
         `Seasonal adjustment`=="Unadjusted",
         Sales=="Units",
         `Origin of manufacture`=="Total, country of manufacture",
         `Vehicle type` %in% c("Passenger cars","Trucks")) 

data.memory %>% head()

## -----------------------------------------------------------------------------
data.parquet %>%
  filter(Date>=as.Date("1990-01-01")) %>%
  ggplot(aes(x=Date,y=val_norm,color=`Vehicle type`)) +
  geom_smooth(span=0.2,method = 'loess', formula = y ~ x) +
  theme(legend.position="bottom") +
  scale_y_continuous(labels = function(d)scales::comma(d,scale=10^-3,suffix="k")) +
  labs(title="Canada new motor vehicle sales",caption="StatCan Table 20-10-0001",
       x=NULL,y="Number of units")

## -----------------------------------------------------------------------------
list_cansim_cached_tables()

## -----------------------------------------------------------------------------
disconnect_cansim_sqlite(connection.sqlite)
remove_cansim_cached_tables("20-10-0001")

