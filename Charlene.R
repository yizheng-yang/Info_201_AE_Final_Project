api.key <- "a3e64d9be5b333a41e4a2182ce906597"
#load libraries
library(plotly)
library("jsonlite")
library("dplyr")
library("httr")

#returns the data for the top 20 most popular
#adult movies(rated R)
GetMostPopularAdultMovies <- function(api.key){
  base.url <- 'https://api.themoviedb.org/3/discover/movie'
  query.params <- list(api_key = api.key,certification_country="US",certification="R",sort_by="popularity.desc")
  response <- GET(base.url, query = query.params)
  body <- content(response, "text")
  results <- fromJSON(body)
  return(results)
}

#returns the data for the top 20 most popular
#kids movies
GetMostPopularKidsMovies <- function(api.key){
  base.url <- 'https://api.themoviedb.org/3/discover/movie'
  query.params <- list(api_key = api.key,certification_country="US",certification.lte="G",sort_by="popularity.desc")
  response <- GET(base.url, query = query.params)
  body <- content(response, "text")
  results <- fromJSON(body)
  return(results)
}
adult.movies <- GetMostPopularAdultMovies(api.key)
kids.movies <- GetMostPopularKidsMovies(api.key)
adult.movies.data <-adult.movies$result
kids.movies.data <- kids.movies$result

#gets the information of cast and crew of a particular movie
GetCredits <- function(movie.id) {
  full.url <- paste0("https://api.themoviedb.org/3/movie/",movie.id,"/credits?api_key=a3e64d9be5b333a41e4a2182ce906597")
  response <- GET(full.url)
  body <- content(response, "text")
  results <- fromJSON(body)
  return(results)
}
adult.movie.credits <- lapply(adult.movies.data$id,GetCredits)
kids.movie.credits <- lapply(kids.movies.data$id, GetCredits)

#merges the female ratio of cast into the adult movies and kids movies dataframes
lforadult <- list()
lforkids <- list()
GetAdultCreditsInfo <- function(index){
  crew.info <- adult.movie.credits[[index]]$crew
  if (is.null(crew.info)){
    return (0)
  }
  female <- filter(crew.info, gender == 1) %>%
    summarise(count = n())
   male <- filter(crew.info, gender == 2) %>%
    summarise(count = n())
  ratio <- round(female / (male + female) * 100, 1)
  return(ratio)
}
GetKidsCreditsInfo <- function(index){
  crew.info <- kids.movie.credits[[index]]$crew
  if (is.null(crew.info)){
    return (0)
  }
    female <- filter(crew.info, gender == 1) %>%
      summarise(count = n())
    male <- filter(crew.info, gender == 2) %>%
      summarise(count = n())
    ratio <- round(female / (male + female) * 100, 1)
    return(ratio)
}
  
i <- 1
while (i <= 20){
  lforadult[[i]] <- GetAdultCreditsInfo(i)
  lforkids[[i]] <- GetKidsCreditsInfo(i)
  i <- i + 1
}
adult.movies.data <- mutate(adult.movies.data, female = lforadult)
adult.movies.data$female <- lapply(adult.movies.data$female, as.numeric)
adult.movies.data <- mutate(adult.movies.data, text = paste0(female, "% of the crew were female"))


kids.movies.data <- mutate(kids.movies.data, female = lforkids)
kids.movies.data$female <- lapply(kids.movies.data$female, as.numeric)
kids.movies.data <- mutate(kids.movies.data, text = paste0(female, "% of the crew were female"))

#draws the graph for the percentage of women crew in top 20
#most popular adult movies
p1 <- plot_ly(adult.movies.data, x = ~title, y = ~female, type = 'bar', 
             text = ~text, textposition = 'auto',
             marker = list(color = 'rgb(158,202,225)',
                           line = list(color = 'rgb(8,48,107)', width = 1.5))) %>%
  layout(title = "Percent of Women Crew in Top 20 Most Popular Adult Movies",
         xaxis = list(title = "Movies"),
         yaxis = list(title = "Percentage of Women Crew")) 

#draws the graph for the percentage of women crew in top 20
#most popular kids movies
p2 <- plot_ly(kids.movies.data, x = ~title, y = ~female, type = 'bar', 
             text = ~text, textposition = 'auto',
             marker = list(color = 'rgb(158,202,225)',
                           line = list(color = 'rgb(8,48,107)', width = 1.5))) %>%
  layout(title = "Percent of Women Crew in Top 20 Most Popular Kids Movies",
         xaxis = list(title = "Movies"),
         yaxis = list(title = "Percentage of Women Crew"))
