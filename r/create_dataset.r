source("./r/utils/create_dataset/get_shot_data.r")

library("rjson") 

home_team <- "Argentina"
away_team <- "Canada"
match <- paste0(home_team, "_vs_", away_team)

json_path  <- paste0("./data/events_copa_america_24/", match)
json_path  <- paste0(json_path, ".json")
match_json <- fromJSON(file = json_path) 

play_type <- c(16) # 16 = shot 30 = pass

for (i in 1:length(match_json)){
    current_play_type <- (match_json[[i]]$type$id)

    if(current_play_type == play_type ){ 
        print(get_shot_data(match_json[[i]]))
        break
    }
}