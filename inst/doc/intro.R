## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  warning = FALSE,
  message = FALSE,
  out.width = "100%"
)

## ----setup, include=FALSE-----------------------------------------------------
library(pell)
library(dplyr)
library(treemap)

## ----eval=FALSE---------------------------------------------------------------
#  install.packages("devtools")
#  devtools::install_github("Curious-Joe/pell")

## -----------------------------------------------------------------------------
dplyr::glimpse(pell)

## ----eval=TRUE, message=FALSE-------------------------------------------------
visdat::vis_dat(pell)

## -----------------------------------------------------------------------------
pell %>%
  dplyr::select(where(is.factor)) %>% 
  dplyr::glimpse()

## -----------------------------------------------------------------------------
# Top 10 institutions with the highest pell grant disbursements
pell %>%
  dplyr::group_by(STATE) %>%
  dplyr::summarise(
    Median = median(.data$AWARD, na.rm = TRUE)
  ) %>%
  dplyr::arrange(desc(Median)) %>%
  head(10) %>%
  knitr::kable(caption = "Top 10 States with the Highest Median Grant Distribution")

## ----message=FALSE------------------------------------------------------------
treemap::treemap(pell,
            index=c("STATE"),
            vSize="AWARD",
            type="index",
            
            ) 

## -----------------------------------------------------------------------------
citation("pell")

