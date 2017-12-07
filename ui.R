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
    
    tabPanel( # home tab
      'Home',
      h1('Gender Inequality in the Movie Industry'),
      img(src="http://cinemajam.com/mag/wp-content/uploads/2015/10/angelina-jolie-directing-unbroken.jpg",
          height="500"),
      h2('Introduction'),
      p('Gender inequality is a persistent issue in the movie and film industry. For the past 
        few decades, inequality in female and male roles in both movies and crew members has shown to become
        an issue still prevalent today. This project examines different factors that contribute to gender
        inequality, such as gender of the director, gender ratios of cast, and intended audience of the film.'),
      HTML("<br>"),
      h2('Investigation Questions'),
      p('1. Does the gender of the director affect the popularity of a movie?'),
      p('2. How does gender ratios (female-to-male) change over the past decade?'),
      p('3. Does the intended audience of the movie affect the gender of the production crew?'),
      HTML("<br>"),
      h2('Data Set'),
      p('The data used for this project is sourced from The Movie Database.'),
      p('Link:'),
      helpText(a("The Movie Database"), href="https://www.themoviedb.org/")
    ),
    
    tabPanel(
      'Director Gender',
      h1('Gender of Director and Popularity Ratings'),
      HTML("<br>"),
      p3,
      h3('Conclusion'),
      text,
      HTML("<br>")
    ),
    
    tabPanel(
      'Publish Year',
      h1('Comparing Gender Ratio of Movie Cast'),
      HTML("<br>"),
      intro,
      HTML("<br><br><br>"),
      p.1990,
      HTML("<br>"),
      p.2010,
      HTML("<br>"),
      p.2017,
      h3('Conclusion'),
      conclusion
    ),
    
    tabPanel(
      'Adults vs. Kids Movies',
      h1('Gender of Production Crew in Adult and Kids Movies'),
      HTML("<br>"),
      p1,
      p2,
      h3('Conclusion'),
      text2,
      HTML("<br>")
    ),
    
    tabPanel( #SEARCH BAR
      'Search Movies',
      h1('Movie details'),
      textInput('search', 'Search movie by name (first 20 results)', value = ''),
      dataTableOutput('searchBar')
    ),
    
    tabPanel(
      'Team & Credit',
      h3('Contribution:  
         '),
      'Fherna Leian Caoili: director gender', br(), br(),
      'Michelle Chang: home page, publish year', br(), br(),
      'Manjia Chen: adults vs. kids movie', br(), br(),
      'Yizheng Yang: search movies, layout'
      ),
    
    theme = shinytheme("cerulean")
  )
)
