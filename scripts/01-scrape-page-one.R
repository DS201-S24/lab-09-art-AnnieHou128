# load packages ----------------------------------------------------------------

library(tidyverse)
library(rvest)

# set url ----------------------------------------------------------------------

first_url <- "https://collections.ed.ac.uk/art/search/*:*/Collection:%22edinburgh+college+of+art%7C%7C%7CEdinburgh+College+of+Art%22?offset=0"

# read first page --------------------------------------------------------------

page <- read_html(first_url)

# scrape titles ----------------------------------------------------------------

titles <- page %>%
  html_nodes("h3.record-title a") %>%
  html_text() %>%
  str_replace_all("\\s+", " ")
  

print(titles)

## scrape links -----------------------------------------------------------------

url <- "https://collections.ed.ac.uk"

links <- page %>%
  html_nodes("h3.record-title a") %>%
  html_attr("href") %>%
  str_replace_all("^\\.", url)

print(links)

## scrape artists ---------------------------------------------------------------

artists <- page %>%
  html_nodes("a.artist") %>%
  html_text(trim = TRUE)

print(artists)

## put together in a data frame -------------------------------------------------

first_ten <- data.frame(
  titles = titles,
  artists = artists,
  links = links
)

head(first_ten)



# scrape second ten paintings --------------------------------------------------

second_url <- "https://collections.ed.ac.uk/art/search/*:*/Collection:%22edinburgh+college+of+art%7C%7C%7CEdinburgh+College+of+Art%22?offset=10"

second_page <- read_html(second_url)

# scrape titles ----------------------------------------------------------------

second_titles <- second_page %>%
  html_nodes("h3.record-title a") %>%
  html_text() %>%
  str_replace_all("\\s+", " ")


print(second_titles)

## scrape links -----------------------------------------------------------------

url <- "https://collections.ed.ac.uk"

second_links <- second_page %>%
  html_nodes("h3.record-title a") %>%
  html_attr("href") %>%
  str_replace_all("^\\.", url)

print(second_links)

## scrape artists ---------------------------------------------------------------

second_artists <- second_page %>%
  html_nodes("a.artist") %>%
  html_text(trim = TRUE)

print(second_artists)

## put together in a data frame -------------------------------------------------

second_ten <- data.frame(
  titles = second_titles,
  artists = second_artists,
  links = second_links
)

head(second_ten)
