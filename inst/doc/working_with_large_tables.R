## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(dplyr)
library(ggplot2)

library(cansim)

## -----------------------------------------------------------------------------
connection <- get_cansim_sqlite("20-10-0001")

## -----------------------------------------------------------------------------
head(connection)

## -----------------------------------------------------------------------------
get_cansim_table_overview("20-10-0001")

## -----------------------------------------------------------------------------
data <- connection %>%
  filter(GEO=="Canada",
         `Seasonal adjustment`=="Unadjusted",
         Sales=="Units",
         `Origin of manufacture`=="Total, country of manufacture",
         `Vehicle type` %in% c("Passenger cars","Trucks")) %>%
  collect_and_normalize()

data %>% head()

## -----------------------------------------------------------------------------
data %>%
  filter(Date>=as.Date("1990-01-01")) %>%
  ggplot(aes(x=Date,y=val_norm,color=`Vehicle type`)) +
  geom_smooth(span=0.2,method = 'loess', formula = y ~ x) +
  theme(legend.position="bottom") +
  scale_y_continuous(labels = function(d)scales::comma(d,scale=10^-3,suffix="k")) +
  labs(title="Canada new motor vehicle sales",caption="StatCan Table 20-10-0001",
       x=NULL,y="Number of units")

## -----------------------------------------------------------------------------
disconnect_cansim_sqlite(connection)

## -----------------------------------------------------------------------------
list_cansim_sqlite_cached_tables()

## -----------------------------------------------------------------------------
remove_cansim_sqlite_cached_table("20-10-0001")

