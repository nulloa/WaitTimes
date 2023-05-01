#' Get wait times
#' 
#' This function will pull wait times for all rides from a given park. The data
#' comes from . See all the available theme parks using the 
#' \code{\link{parks}} function.
#' 
#'
#' @param parkid The park id for the park you'd like to see
#' @param dates A two element character vector date range
#' @return A dataframe
#'
#' @examples
#' waitTimes("66", "01-02-2023")
#' 
#' @export
waitTimes <- function(parkid, dates){
  
  tmp <- jsonlite::fromJSON(txt = paste0("https://queue-times.com/en-US/parks/", parkid, "/queue_times.json"))
  
  
  
  df <- do.call(rbind, lapply(seq_along(tmp$lands), function(x) {
    tmp$lands[[x]]$land <- names(tmp$lands)[x]
    tmp$lands[[x]]
  }))
  
}



