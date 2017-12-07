library(shiny)
library(httr)
library(jsonlite)
library(dplyr)
library(knitr)
source('api-key.R')

shinyServer(function(input, output) {
  
  output$searchBar <- renderDataTable({
    query <- gsub(' ',',',input$search)
    raw.data4 <- GET(paste0('https://api.themoviedb.org/3/search/movie?api_key=',api.key,'&query=',
                            query,'&page=1'))
    parsed.data4 <- content(raw.data4, 'text') %>%
      fromJSON()
    if(is.null(parsed.data4$results)){ #empty case
      return(data.frame('Please Enter Movie Name'))
    }
    if(length(parsed.data4$results) == 0){ #no match case
      return(data.frame('No Results'))
    }
    #is.data.frame(parsed.data4$results)
    results.data4 <- parsed.data4$results %>%
      select(title,release_date,original_language,vote_count,vote_average,overview) #select variables from data
    return(results.data4)
  }, options = list(pageLength = 10))
  
})
