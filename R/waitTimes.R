#' Get wait times
#' 
#' This function will pull wait times for all rides from a given park. The data
#' comes from . See all the available theme parks using the \code{data(parks)}.
#' Will need internet to run.
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
  
  if(length(tmp$lands!=0)){
    # park has lands
    
    # Set lands to names of lists
    names(tmp$lands$rides) <- tmp$lands[,2]
    
    # merge lands while adding land names
    df <- do.call(rbind, lapply(seq_along(tmp$lands$rides), function(x) {
      tmp$lands$rides[[x]]$land <- names(tmp$lands$rides)[x]
      tmp$lands$rides[[x]]
    }))
    
  }else{
    # park has no lands
    df <- cbind(tmp$rides, land = NA)
  }
  
  return(df)
  
}



