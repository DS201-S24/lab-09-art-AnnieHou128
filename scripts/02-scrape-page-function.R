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
 # artists <- page %>%
 #   html_nodes(".artist") %>%
 #   html_text(trim = TRUE)
 artists <- page %>% 
   html_nodes(".iteminfo") %>%
   map_chr(getArtist)


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

# fifth_url = "https://collections.ed.ac.uk/art/search/*:*/Collection:%22edinburgh+college+of+art%7C%7C%7CEdinburgh+College+of+Art%22?offset=50"
# scrape_page(fifth_url)


getArtist <- function(oneNode){
  oneArtist <- oneNode %>%
    html_nodes(".artist") %>%
    html_text(trim = TRUE)
  
  if(length(oneArtist) == 0) oneArtist <- ""
  if(length(oneArtist) > 1) return(paste0(oneArtist, collapse=", "))
  return(oneArtist)
}