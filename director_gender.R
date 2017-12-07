library(dplyr)
library(httr)
library(jsonlite)
library(plotly)

source('api-key.R')

#Function returns list of movies
GetMovie <- function(page.number) {
  base.url <- "https://api.themoviedb.org/3/discover/movie"
  query.params <- list(page = page.number, with_original_language = "en", primary_release_year = 2017, api_key = api.key)
  response <- GET(base.url, query = query.params) 
  body <- content(response, "text")
  results <- fromJSON(body)
  movies <- flatten(results$results)
  return(movies)
}

#Combines movies from page 1 and 2
movies <- rbind(GetMovie(1), GetMovie(2))

#Takes the movie id's and makes them into a list
movie.id <- as.list(movies$id)

#Function retrieves crew members of each movie
GetCrew <- function(id) {
  base.url <- paste0("https://api.themoviedb.org/3/movie/", id , "/credits")
  query.params <- list(movie_id = id, api_key = api.key)
  response <- GET(base.url, query = query.params) 
  body <- content(response, "text")
  results <- fromJSON(body)
  crew <- flatten(results$crew)
  return(crew)
} 
Sys.sleep(10)
#Applies function to all movie id's 
movie.crew <- lapply(movie.id, GetCrew)

#Filters entire crew list to only the director
GetCrewInfo <- function(index){
  crew.info <- movie.crew[[index]]
  crew.info <- filter(crew.info, job == "Director")
  director.info <- data.frame(crew.info, "movie_name" = movies[index,5], "popularity" = movies[index,1]) 
  director.info <- select(director.info,name,job, gender, movie_name, popularity)
  return(director.info)  
}


#Combines directors into one list
list.of.directors <- rbind(GetCrewInfo(1),GetCrewInfo(2),GetCrewInfo(3),GetCrewInfo(4),GetCrewInfo(5),GetCrewInfo(6),GetCrewInfo(7),
      GetCrewInfo(8),GetCrewInfo(9),GetCrewInfo(10),GetCrewInfo(11),GetCrewInfo(12),GetCrewInfo(13),GetCrewInfo(14),
      GetCrewInfo(15),GetCrewInfo(16),GetCrewInfo(17),GetCrewInfo(18),GetCrewInfo(19),GetCrewInfo(20))

list.of.directors <- rbind(list.of.directors,GetCrewInfo(21),GetCrewInfo(22),GetCrewInfo(23),GetCrewInfo(24),GetCrewInfo(25),GetCrewInfo(26),GetCrewInfo(27),
                           GetCrewInfo(28),GetCrewInfo(29),GetCrewInfo(30),GetCrewInfo(31),GetCrewInfo(32),GetCrewInfo(33),GetCrewInfo(34),
                           GetCrewInfo(35),GetCrewInfo(36),GetCrewInfo(37),GetCrewInfo(38),GetCrewInfo(39),GetCrewInfo(40))

list.of.directors$gender[list.of.directors$gender == "2"] <- "Male"
list.of.directors$gender[list.of.directors$gender == "1"] <- "Female"
list.of.directors$gender[list.of.directors$gender == "0"] <- "Not Specified"

#Plots scatterplot of gender vs popularity of movie
p3 <- plot_ly(list.of.directors, x = ~gender, y = ~popularity, type = 'scatter', 
              text = ~paste(movie_name, "<br>Director:", name, "<br>Popularity:", popularity),
              color = ~popularity, hoverinfo = "text") %>%
  layout(title = "Does the director's gender affect the popularity of their movie?",
         xaxis = list(title = "Gender"),
         yaxis = list(title = "Popularity Counts")) 

text <- "Most people would think males and females would share roles in being director of movies and that
their movie would be succesful either way. But looking at this, majority of director roles are given to males 
and only ONE person is a female while three other people did not want to disclose their gender, but unfortunately
their movies are not so popular. Even though majority of directors in this set of movies are male, there are still
a few of their movies that are not so popular. It's unfortunate that only one person in this set of directors is female while
the rest are males. But this tells us that majority of director roles are occupied by males."
