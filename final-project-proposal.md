# Info 201 Final Project Proposal

**Link to GitHub repository:** https://github.com/yizheng-yang/Info_201_AE_Final_Project

## PROJECT DESCRIPTION
**Background of Data Set**
For our final project, our group will be using the Studio Ghibli API. This API does not require any authentication (it does not require any API keys). It has endpoints containing basic information like movie title, summary, release date, director. This API is compiled by Juan Soto, and the creator’s repository can be found on his github website at https://github.com/sotojuan.

**BIG UPDATE**
After exploring this API more, we decided to change to a new API from [The Movie DB](https://www.themoviedb.org/) because it contained more complete information and also are larger dataset to work with.

**Target Audience**
The target audience for this project is anyone who has interests in anime or in any particular Studio Ghibli film they would like to know more information about.

**Questions that will be investigated**
UPDATED: We are now investigating the different ways gender inequality manifests in the film industry. We will be exploring the different effects that gender has on movie popularity, year published, and audience of the movie.

## TECHNICAL DESCRIPTION
**Format**
The final project will be a Shiny app. The data that will be read into our app will be from the Studio Ghibli API mentioned above.

**Data Wrangling**
To get the data that we want, we have to create data frames with the information that we get from the API. For example, we might want to make a data frame of each movie with basic information for the movie (title, year, summary, director, etc).

**Libraries used**
We will be utilizing the `plot.ly` library to generate graphs and data visualizations. We will also be using the `dplyr` and `knitr` libraries to format the app and extract the data we want.

UPDATED: We also used `jsonlite` and `httr` to read data from the API, and used a `shinythemes` library to apply a theme to the final website.

**Questions to be answered**
UPDATED
1. Does the gender of the director affect the popularity of a movie?
2. How does gender ratios (female-to-male) change over the past decade?
3. Does the intended audience of the movie affect the gender of the production crew?

**Anticipated challenges**
A challenged that we might face is deciding on the format that our information will be displayed in. For instance, we have decided to use a timeline to show the order of the movies that Studio Ghibli had produced, but we will have to find a way to make the timeline more interesting by adding interactive elements to it.

Another challenge that can make this project difficult is deciding how to organize the information from the API. The API we are using provides a lot of basic information about the movies and categorizes them into subcategories such as location, people, and species (of characters). Utilizing this information and making it into a visual that is interesting and appealing to the audience is something that we will have to take into careful consideration.
