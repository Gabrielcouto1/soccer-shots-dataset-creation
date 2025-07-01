source("./r/utils/create_dataset/get_shot_data.r")
source("./r/utils/get_match_json.r")


create_csvs <- function(competitions_list) {
    execution_times <- c()
    matches_count   <- c()
    shots_collected <- c()
    total_matches   <- 2441

    if (!dir.exists("./datasets")) {
    dir.create("./datasets")
    }

    for(i in 1:length(competitions_list)){
        start_time <- Sys.time()
        competition <- competitions_list[i]
        competition_folder <- paste0("./data/events/events_", competition, "/")

        all_matches_jsons <- list.files(path=competition_folder, pattern="\\.json$", full.names=TRUE)
        matches_count <- c(matches_count, length(all_matches_jsons))

        list_of_shot_dfs <- list()

        shot_event_id  <- 16 # 16 = shot 30 = pass
        all_shots_data <- list()
        match_index <- 1

        for (match_file_path in all_matches_jsons){
            print(paste0("Processing match ", match_index, ": ", basename(match_file_path), ". ", round(match_index/total_matches*100, 2), "% done."))
            
            match_index      <- match_index + 1
            match_json       <- fromJSON(file=match_file_path)

            home_team        <- match_json[[1]]$team$name
            away_team        <- match_json[[2]]$team$name
            season           <- match_json[[1]]$season
            match_id         <- match_json[[1]]$match_id
            competition_name <- match_json[[1]]$competition_name

            all_shot_events <- Filter(function(play) !is.null(play$type$id) && play$type$id == shot_event_id, match_json)

            if (length(all_shot_events) > 0) {
                list_of_shot_data <- lapply(all_shot_events, get_shot_data, 
                                            home_team=home_team, 
                                            away_team=away_team, 
                                            season=season,
                                            match_id=match_id,
                                            competition_name=competition_name,
                                            match_json=match_json)
                
                shots_from_single_match_df <- dplyr::bind_rows(list_of_shot_data)
                
                list_of_shot_dfs[[length(list_of_shot_dfs) + 1]] <- shots_from_single_match_df
                
            } else {
                print(paste("No shots found in", basename(match_file_path), ""))
            }
        }
        all_shots_dataset <- dplyr::bind_rows(list_of_shot_dfs)
        shots_collected   <- c(shots_collected, nrow(all_shots_dataset))

        csv_file_path <- paste0("./datasets/", competition, "_shots.csv")
        write.csv(all_shots_dataset, file = csv_file_path, row.names = FALSE)

        end_time <- Sys.time()
        execution_times <- c(execution_times, end_time - start_time)
    }

    csv_files <- c()

    for(i in 1:length(competitions)){
        cat(paste0("--------------------------------------------------------------------------------\n",
                "Time taken for ", competitions[i], ": ", execution_times[i], " minutes.\n",
                "Processed ", matches_count[i], " matches.\n",
                "Collected ", shots_collected[i], " shots.\n"))
        csv_files <- c(csv_files, paste0("./datasets/", competitions[i], "_shots.csv"))
    }

    cat(paste0("\n\n================================================================================\n",
                "Time taken in total: ", sum(execution_times), " minutes.\n",
                "Processed ", sum(matches_count), " matches in total.\n",
                "Collected ", sum(shots_collected), " shots in total.\n"))

    combined_df <- map_dfr(csv_files, read_csv, show_col_types = FALSE)
    write_csv(combined_df, "./datasets/shots.csv")

    cat(paste0("\n\n Combined all ", length(competitions), " datasets into one and saved it into ./datasets/shots.csv."))
}
