library("rjson") 
library("dplyr")
options("width"=200)

source("./r/utils/create_dataset/get_shot_data.r")
source("./r/utils/get_match_json.r")

competition_folder <- "./data/events_la_liga/"

all_matches_jsons <- list.files(path=competition_folder, pattern="\\.json$", full.names=TRUE)

list_of_shot_dfs <- list()

print(paste("Found", length(all_matches_jsons), "match files to process."))

shot_event_id  <- 16 # 16 = shot 30 = pass
all_shots_data <- list()

for (match_file_path in all_matches_jsons){
    print(paste("Processing match:", basename(match_file_path), ""))
    
    match_json <- fromJSON(file=match_file_path)

    all_shot_events <- Filter(function(play) !is.null(play$type$id) && play$type$id == shot_event_id, match_json)

    if (length(all_shot_events) > 0) {
        list_of_shot_data <- lapply(all_shot_events, get_shot_data)
        
        shots_from_single_match_df <- dplyr::bind_rows(list_of_shot_data)
        
        list_of_shot_dfs[[length(list_of_shot_dfs) + 1]] <- shots_from_single_match_df
        
    } else {
        print(paste("No shots found in", basename(match_file_path), ""))
    }
}

if (length(list_of_shot_dfs) > 0) {
    all_shots_dataset <- dplyr::bind_rows(list_of_shot_dfs)

    print(paste("Total number of shots collected:", nrow(all_shots_dataset), ""))
    print(head(all_shots_dataset))
    str(all_shots_dataset)
    
    csv_file_path <- "./dataset/la_liga_shots.csv"
    write.csv(all_shots_dataset, file = csv_file_path, row.names = FALSE)
    print(paste("Dataset saved to:", csv_file_path, ""))
    
} else {
    print("an error has ocurred")
}