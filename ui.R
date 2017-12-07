library(shiny)
library(httr)
library(jsonlite)
library(dplyr)
library(knitr)
library(shinythemes)
source('api-key.R')

source('certification.R')
Sys.sleep(10)
source('director_gender.R')
Sys.sleep(10)
source('release_date.R')

shinyUI(navbarPage(
  
    title = "Gender Inequality in Movies",
    
    tabPanel(
      'Home',
      'add content'
    ),
    
    tabPanel(
      'Director Gender',
      p3
    ),
    
    tabPanel(
      'Publish Year',
      p.1990,
      p.2010,
      p.2017
    ),
    
    tabPanel(
      'Adults vs. Kids Movie',
      p1,
      p2,
      'add paragraph'
    ),
    
    tabPanel( #SEARCH BAR
      'Search Movies',
      textInput('search', 'search movie by name (first 20 results)', value = ''),
      dataTableOutput('searchBar')
    ),
    
    tabPanel(
      'Team&Credit',
      'add content'
    ),
    
    theme = shinytheme("cerulean")
  )
)
