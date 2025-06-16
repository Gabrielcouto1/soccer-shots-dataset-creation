library("rjson") 

source("./r/utils/xg/get_shot_xg.r")

get_match_xg <- function(match){
    play_type <- 16 # 16 = shot 30 = pass

    home_xg <- c()
    away_xg <- c()

    for (i in 1:length(match)){
        current_play_type <- (match[[i]]$type$id)

        if(current_play_type == play_type ){ 
            if (match[[i]]$team$name == away_team){
                xg <- get_shot_xg(match[[i]])
                away_xg <- c(away_xg, xg)
            } else{
                xg <- get_shot_xg(match[[i]])
                home_xg <- c(home_xg, xg)
            }
        }
    }

    return(list(home_xg = home_xg, away_xg = away_xg))
}

