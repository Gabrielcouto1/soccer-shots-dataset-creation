library("rjson") 

source("./r/utils/create_dataset/get_shot_data.r")
source("./r/utils/get_match_json.r")

match_json = get_match_json("Argentina", "Canada", 1)

play_type <- c(16) # 16 = shot 30 = pass

for (i in 1:length(match_json)){
    current_play_type <- (match_json[[i]]$type$id)

    if(current_play_type == play_type ){ 
        print(get_shot_data(match_json[[i]]))
        break
    }
}