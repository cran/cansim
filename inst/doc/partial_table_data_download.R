## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  cache = FALSE,
  eval = nzchar(Sys.getenv("COMPILE_VIG"))
)

## ----setup--------------------------------------------------------------------
library(cansim)
library(dplyr)
library(ggplot2)

bp_template <- get_cansim_table_template("34-10-0285")

head(bp_template)

## -----------------------------------------------------------------------------
bp_template_filtered <- bp_template %>%
  filter(Geography %in% c("Toronto, Ontario", "Montréal, Quebec", "Vancouver, British Columbia", "Calgary, Alberta"),
         `Type of building` %in% c("Total residential","Total demolitions"),
         `Type of work` %in% c("Demolitions for residential dwellings","Deconversion total","Conversions total","New dwelling units total"),
         Variables %in% c("Number of dwelling-units created", "Number of dwelling-units lost", "Number of dwelling-units demolished"),
         `Seasonal adjustment, value type` == "Unadjusted, current"
  )

bp_template_filtered

## -----------------------------------------------------------------------------
bp_data <- get_cansim_data_for_table_coord_periods(bp_template_filtered)

bp_data

## ----fig.alt="Vignette example plot, building and demolition permits"---------
bp_data |>
  mutate(Value=case_when( # count demolitions and deconversions as negative
    Variables %in% c("Number of dwelling-units demolished","Number of dwelling-units lost") ~ - val_norm,
    TRUE ~ val_norm
  )) |>
  mutate(Name=gsub(", .+","",GEO),
         Year=strftime(Date,"%Y")) |>
  summarize(Value=sum(Value),n=n(),.by=c(Name,Year,`Type of work`)) |>
  filter(n==12,!is.na(Value)) |> # only show years with complete 12 months of data
  ggplot(aes(x=Year,y=Value,fill=`Type of work`)) +
  geom_bar(stat="identity") +
  facet_wrap(~Name,scales="free_y") +
  scale_y_continuous(labels=scales::comma) +
  theme(axis.text.x = element_text(angle=90, hjust=1)) +
  labs(title="Building permits for residential structures in Canadian metro areas",
       y="Number of dwelling units",
       x=NULL,
       fill="Metric",
       caption="StatCan Table 34-10-0285") 

## -----------------------------------------------------------------------------
bp_template_filtered_vecotrs <- bp_template_filtered |>
  add_cansim_vectors_to_template()

bp_data_vector <- bp_template_filtered_vecotrs$VECTOR |>
  na.omit() |>
  get_cansim_vector()

## ----fig.alt="Vignette example plot, building and demolition permits"---------
bp_data_vector |>
  mutate(Value=case_when( # count demolitions and deconversions as negative
    Variables %in% c("Number of dwelling-units demolished","Number of dwelling-units lost") ~ - val_norm,
    TRUE ~ val_norm
  )) |>
  mutate(Name=gsub(", .+","",GEO),
         Year=strftime(Date,"%Y")) |>
  summarize(Value=sum(Value),n=n(),.by=c(Name,Year,`Type of work`)) |>
  filter(n==12,!is.na(Value)) |> # only show years with complete 12 months of data
  ggplot(aes(x=Year,y=Value,fill=`Type of work`)) +
  geom_bar(stat="identity") +
  facet_wrap(~Name,scales="free_y") +
  scale_y_continuous(labels=scales::comma) +
  theme(axis.text.x = element_text(angle=90, hjust=1)) +
  labs(title="Building permits for residential structures in Canadian metro areas",
       y="Number of dwelling units",
       x=NULL,
       fill="Metric",
       caption="StatCan Table 34-10-0285") 

