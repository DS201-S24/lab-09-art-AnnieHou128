# load packages ----------------------------------------------------------------

library(tidyverse)
library(rvest)

# function: scrape_page --------------------------------------------------------

scrape_page <- function(url) {

 # read page
 page <- read_html(url)

 # scrape titles
 titles <- page %>%
   html_nodes("h3.record-title a") %>%
   html_text() %>%
   str_replace_all("\\s+", " ")

 # scrape artists
 artists <- page %>%
   html_nodes(".artist") %>%
   html_text(trim = TRUE)

 # scrape links
 base_url <- "https://collections.ed.ac.uk"
 links <- page %>%
   html_nodes("h3.record-title a") %>%
   html_attr("href") %>%
   str_replace_all("^\\.", base_url)

 # create and return data frame
 df <- data.frame(
   titles = titles,
   artists = artists,
   links = links
 )

 return(df)

}

scrape_page(first_url)
scrape_page(second_url)