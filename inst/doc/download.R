## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----eval = FALSE-------------------------------------------------------------
#  # 0.1 Loading Libraries ----
#  library(readxl)
#  library(rvest)
#  library(tidyverse)
#  library(httr)
#  library(janitor)
#  library(patchwork)
#  library(glue)
#  
#  # 0.0 Variables ----
#  raw_data_loc = "data-raw/yearly-data/"
#  url <- "https://www2.ed.gov/finaid/prof/resources/data/pell-institution.html"
#  downloadString <- "https://www2.ed.gov/finaid/prof/resources/data/"
#  
#  # 1.0 DATA SOURCING ----
#  
#  # 1.1 Web Scraping ----
#  htmlOutput <- read_html(url)
#  
#  # collect years
#  years <- htmlOutput %>%
#    html_nodes(".smallindent") %>%
#    html_text() %>%
#    substr(1, 7)
#  
#  # collects download link
#  reportLinks <- htmlOutput %>%
#    html_nodes(".smallindent > a") %>%
#    html_attr('href') %>%
#    unique()
#  
#  # year and report match
#  reportSources <- tibble(
#    years = years,
#    report_link = paste0(downloadString, reportLinks)
#  )
#  
#  
#  # 1.2 Collecting Data ----
#  downloadData <- function(reportSourcesDF, storageLocation){
#  
#    df <- tibble()
#  
#    for(i in seq(1, nrow(reportSourcesDF), 1)){
#      reportYear <- reportSourcesDF[i, 1]$years
#      report <- reportSourcesDF[i,2]
#      fileExt <- tools::file_ext(report)
#      outputLocation <- glue::glue("{storageLocation}/{reportYear}.csv")
#  
#      # downloads and save file temporarily
#      GET(report$report_link, write_disk(
#        yearlyReport <- tempfile(fileext = fileExt))
#      )
#      # removes introductory paragraphs from the excel files
#      yearlyReport = read_excel(yearlyReport, col_names = F)
#      yearlyReport <- yearlyReport[!is.na(yearlyReport[,1]), ]
#      yearlyReport <- yearlyReport[!is.na(yearlyReport[,2]), ]
#      yearlyReport <- yearlyReport[!is.na(yearlyReport[,3]), ]
#  
#      # promotes first full row as column names
#      yearlyReport <- yearlyReport %>%
#        janitor::row_to_names(row_number = 1)
#  
#      # writes back to the desired location
#      yearlyReport %>%
#        write_excel_csv(outputLocation)
#  
#      # populates a summary report with col names
#      cols <- as_tibble(names(yearlyReport))
#      cols$year <- reportYear
#      df <- rbind(df, cols)
#    }
#  
#    return(df)
#  }
#  
#  # downloads all the files and saving them in the location provided in downloadData() as storageLocation argument.
#  reportSourcesSummary <- downloadData(reportSources, raw_data_loc)
#  

