library("rjson")

get_match_outcome <- function(match, competition, match_id) {
    folder_path <- paste0("./data/matches_list/", competition, "_matches")
    json_files <- list.files(path = folder_path, pattern = "\\.json$", full.names = TRUE)
    
    if (length(json_files) == 0) {
        stop(paste("No JSON files found in the specified folder:", folder_path))
    }
    
    
    for (file_path in json_files) {
    matches_data <- fromJSON(file = file_path)
    
    for (match_info in matches_data) {
      if (!is.null(match_info$match_id) && match_info$match_id == match_id) {
        home_score <- match_info$home_score
        away_score <- match_info$away_score
        
        return(paste0(home_score, "x", away_score))
      }
    }
  }
  
  stop(paste("Match with ID not found:", match_id))

}   