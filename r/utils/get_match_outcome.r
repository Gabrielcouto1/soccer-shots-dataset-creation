library("rjson")

get_match_outcome <- function(match) {
    matches_data <- fromJSON(file = "./data/copa_america_24_matches.json")
    

    match_parts <- strsplit(match, "_vs_")[[1]]
    
    if (length(match_parts) != 2) {
        stop("Match string must be in format 'Team1_vs_Team2'")
    }
    
    home_team_name <- match_parts[1]
    away_team_name <- match_parts[2]
    
    match_found <- FALSE
    for (i in 1:length(matches_data)) {
      match_info <- matches_data[[i]]

      if (match_info$home_team$home_team_name == home_team_name && 
            match_info$away_team$away_team_name == away_team_name) {
            
        home_score <- match_info$home_score
        away_score <- match_info$away_score

        result <- paste0(home_score, "x", away_score)
        match_found <- TRUE
        break
      }
    }
    
    if (!match_found) {
        stop(paste("Match not found:", match))
    }
    
    return(result)
}   