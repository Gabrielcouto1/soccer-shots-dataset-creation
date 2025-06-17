library("rjson") 
options("width"=200)

source("./r/utils/create_dataset/get_shot_data.r")
source("./r/utils/get_match_json.r")

match_json = get_match_json("Argentina", "Canada", 1)

play_type <- c(16) # 16 = shot 30 = pass
all_shots_data <- list()

for (i in 1:length(match_json)){
    current_play <- match_json[[i]]

    if(!is.null(current_play$type$id) && current_play$type$id == play_type ){ 
        shot_data <- get_shot_data(current_play)
        all_shots_data[[length(all_shots_data) + 1]] <- shot_data
    }
}

shots_df <- do.call(rbind, lapply(all_shots_data, as.data.frame))

print(head(shots_df))
str(shots_df)