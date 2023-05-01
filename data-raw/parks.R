#' Gen data.frame of theme parks
#' 
#' This function will generate the data.frame of theme parks from 
#' \href{queue-times.com/en-US}{Queue-Times.com}
#' 
#' @param tosave Whether or not to save the data (T/F)
#' 
#' @return A dataframe
#'
#' @examples
#' gen_park_data()
#' 
gen_park_data <- function(tosave=FALSE){
  
  # get the parks
  tmp <- jsonlite::fromJSON(txt = "https://queue-times.com/en-US/parks.json")
  
  # name the dataframes
  names(tmp$parks) <- tmp[,2]
  
  # unlist the lists and combine them row wise
  parklist <- do.call(rbind, lapply(seq_along(tmp$parks), function(x) {
    tmp$parks[[x]]$company <- names(tmp$parks)[x]
    tmp$parks[[x]]
  }))
  
  # rearrange the columns
  parks <- parklist[ ,c("id","company","name","country","continent","latitude","longitude","timezone")]
  
  # Save the data
  if(tosave){
    write.csv(parks, "data-raw/parks.csv", row.names=FALSE)
    usethis::use_data(parks, overwrite = TRUE)
  }
  
}