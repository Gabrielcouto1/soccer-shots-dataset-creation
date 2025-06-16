library("rjson") 

get_match_json <- function(home_team, away_team, competition){
    match <- paste0(home_team, "_vs_", away_team)

    if(competition){
        json_path  <- paste0("./data/events_copa_america_24/", match, ".json")
    }else{
        json_path  <- paste0("./data/events_uefa_euro_24/", match, ".json")
    }
    return (fromJSON(file = json_path)) 
}