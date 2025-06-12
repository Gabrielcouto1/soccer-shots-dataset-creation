library("rjson") 

source("./r/utils/xg/get_shot_xg.r")

get_match_xg <- function(match){
    json_path  <- paste0("./data/events_copa_america_24/", match)
    json_path  <- paste0(json_path, ".json")
    match_json <- fromJSON(file = json_path) 

    play_type <- 16 # 16 = shot 30 = pass

    home_xg <- c()
    away_xg <- c()

    for (i in 1:length(match_json)){
        current_play_type <- (match_json[[i]]$type$id)

        if(current_play_type == play_type ){ 
            if (match_json[[i]]$team$name == away_team){
                xg <- get_shot_xg(match_json[[i]])
                away_xg <- c(away_xg, xg)
            } else{
                xg <- get_shot_xg(match_json[[i]])
                home_xg <- c(home_xg, xg)
            }
        }
    }

    return(list(home_xg = home_xg, away_xg = away_xg))
}

