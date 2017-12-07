# Comparing Gender Ratio of Movie Cast
# These charts below takes the 20 most popular movies (based on user ratings from The Movie DB) for 
# a given year, and compares the ratios of females to males that appear in the movie. The ratio is 
# calculated by dividing the number of female characters by the number of male characters.
# If the ratio is greater than 1, there are more females than males; if the ratio is less than 1, there 
# are more males than females.

library('dplyr')
library('plotly')
library('httr')
library('jsonlite')
library('plotly')

source("api-key.R")

# takes in a year and returns a data frame of the 20 most popular movies given a year
GetMovieByYear <- function(year) {
  base.url <- paste0("https://api.themoviedb.org/3/discover/movie")
  query.params <- list(api_key = api.key, primary_release_year=year)
  response <- GET(base.url, query = query.params)
  body <- content(response, "text")
  parsed.data <- fromJSON(body)
  flattened <- as.data.frame(parsed.data$results)
  
  vote <- flattened %>% 
    select(vote_count)
  title <- flattened %>% 
    select(title)
  id <- flattened %>% 
    select(id)
  avg <- flattened %>% 
    select(vote_average)
  
  info <- list(id=id, title=title, vote=vote, avg=avg)
  return(info)
}

movies.1990 <- as.data.frame(GetMovieByYear(1990))
movies.2010 <- as.data.frame(GetMovieByYear(2010))
movies.2017 <- as.data.frame(GetMovieByYear(2017))

# Gets a data frame of cast for most popular movies for a given year
GetGenderRatio <- function(id) {
  base.url <- paste0("https://api.themoviedb.org/3/movie/", id, "/credits")
  query.params <- list(api_key = api.key)
  response <- GET(base.url, query = query.params)
  body <- content(response, "text")
  parsed.data <- fromJSON(body)
  flattened <- flatten(parsed.data$cast)

  female <- group_by(flattened, gender) %>% 
    filter(gender == "1") %>% 
    nrow()
  male <- group_by(flattened, gender) %>% 
    filter(gender == "2") %>% 
    nrow()
  unspecified <- group_by(flattened, gender) %>% 
    filter(gender == "0") %>% 
    nrow()
  
  female.male.ratio <- female/male
  return(female.male.ratio)
}

# matches gender ratio with movie data frame
movies.ratio.1990 <- lapply(movies.1990$id, GetGenderRatio)
movies.1990 <- mutate(movies.1990, movies.ratio.1990)
Sys.sleep(10)
movies.ratio.2010 <- lapply(movies.2010$id, GetGenderRatio)
movies.2010 <- mutate(movies.2010, movies.ratio.2010)
Sys.sleep(10)
movies.ratio.2017 <- lapply(movies.2017$id, GetGenderRatio)
movies.2017 <- mutate(movies.2017, movies.ratio.2017)

a <- list(
  title = "Movie",
  showticklabels = TRUE,
  tickangle = 35
)

# Barplot of Cast Ratio 1990
p.1990 <- plot_ly(
  x = movies.1990$title,
  y = movies.1990$movies.ratio.1990,
  name = "Cast Gender Ratio: 1990",
  type = "bar",
  marker = list(color = c('rgba(30,182,182,0.7)'))
) %>% 
  layout(
    title = "Cast Gender Ratio: 1990",
    yaxis = list(title ='Female-to-male ratio'),
    xaxis = a,
    margin = list(l=50, r=80, b=150, t=25)
  ) 

# Barplot of Cast Ratio 2010
p.2010 <- plot_ly(
  x = movies.2010$title,
  y = movies.2010$movies.ratio.2010,
  name = "Cast Gender Ratio: 2010",
  type = "bar",
  marker = list(color = c('rgba(24,138,138,0.7)'))
) %>% 
  layout(
    title = "Cast Gender Ratio: 2010",
    yaxis = list(title ='Female-to-male ratio'),
    xaxis = a,
    margin = list(l=50, r=80, b=250, t=25)
  ) 

# Barplot of Cast Ratio 2017
p.2017 <- plot_ly(
  x = movies.2017$title,
  y = movies.2017$movies.ratio.2017,
  name = "Cast Gender Ratio: 2017",
  type = "bar",
  marker = list(color = c('rgba(9,52,52,0.7)'))
) %>% 
  layout(
    title = "Cast Gender Ratio: 2017",
    yaxis = list(title ='Female-to-male ratio'),
    xaxis = a,
    margin = list(l=50, r=100, b=250, t=25)
  ) 
