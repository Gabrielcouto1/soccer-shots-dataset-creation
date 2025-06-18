library("rjson") 

get_match_json <- function(home_team, away_team, competition){
    match <- paste0(home_team, "_vs_", away_team)

    json_path  <- paste0("./data/events/events_", competition, "/", match, ".json")
    
    return (fromJSON(file = json_path)) 
}