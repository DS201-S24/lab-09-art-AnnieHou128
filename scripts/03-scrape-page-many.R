# load packages ----------------------------------------------------------------

library(tidyverse)
library(rvest)

# list of URLs to be scraped ---------------------------------------------------

root <- "https://collections.ed.ac.uk/art/search/*:*/Collection:%22edinburgh+college+of+art%7C%7C%7CEdinburgh+College+of+Art%22?offset="
last_offset=3270
numbers <- seq(from = 0, to = last_offset, by = 10)
urls <- paste0(root, numbers)


# map over all URLs and output a data frame ------------------------------------

art <- map_df(urls, scrape_page) # this will take 5-10 minutes

# write out data frame ---------------------------------------------------------

write_csv(art, file = "data/art.csv")


