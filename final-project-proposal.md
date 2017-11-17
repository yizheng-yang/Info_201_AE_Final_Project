# Info 201 Final Project Proposal

**Link to GitHub repository:** https://github.com/yizheng-yang/Info_201_AE_Final_Project

## PROJECT DESCRIPTION
**Background of Data Set**
For our final project, our group will be using the Studio Ghibli API. This API does not require any authentication (it does not require any API keys). It has endpoints containing basic information like movie title, summary, release date, director. This API is compiled by Juan Soto, and the creator’s repository can be found on his github website at https://github.com/sotojuan.

**Target Audience**
The target audience for this project is anyone who has interests in anime or in any particular Studio Ghibli film they would like to know more information about.

**Questions that will be investigated**
This project will investigate the timeline of different Studio Ghibli movies.
In addition, it will also include visualizations to answer what species, locations, and people appear the most in the movies.
The project will also compare ratings of movies and determine if the director of the movie has any relationship to the specific rating that the movie received (on a scale from 0 - 100).

## TECHNICAL DESCRIPTION
**Format**
The final project will be an Shiny app. The data that will be read into our app will be from an API.

**Data Wrangling**
To get the data that we want, we have to create data frames with the information that we get from the API. For example, we might want to make a data frame of each movie with basic information for the movie (title, year, summary, director, etc).

**Libraries used**
We will be utilizing the `plot.ly` library to generate graphs and data visualizations. We will also be using the `dplyr` and `knitr` libraries to format the app and extract the data we want.

**Questions to be answered**
1. What is the chronological order that Studio Ghibli movies were released? (Timeline of all movies)
2. How do the ratings of each movie compare with other Studio Ghibli movies?
3. Is there a relationship between the movie’s ratings and the director of that movie?
4. What are the different species that are seen in Studio Ghibli movies? (EX: human, spirit, cat)
5. What are the most popular setting used in the movies? Which locations occur the most in these movies? (Land, river, forest, city, etc.)

**Anticipated challenges**
A challenged that we might face is deciding on the format that our information will be displayed in. For instance, we have decided to use a timeline to show the order of the movies that Studio Ghibli had produced, but we will have to find a way to make the timeline more interesting by adding interactive elements to it.

Another challenge that can make this project difficult is deciding how to organize the information from the API. The API we are using provides a lot of basic information about the movies and categorizes them into subcategories such as location, people, and species (of characters). Utilizing this information and making it into a visual that is interesting and appealing to the audience is something that we will have to take into careful consideration.
