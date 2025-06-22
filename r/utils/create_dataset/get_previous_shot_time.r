get_previous_shot_time <- function(match_json, shot) {
    shot_time <- shot$minute * 60 + shot$second
    last_shot_time <- NA

    for (event in match_json) {
        if (event$id == shot$id) {
            break
        }

        if (!is.null(event$type$name) && event$type$name == "Shot") {
            last_shot_time <- event$minute * 60 + event$second
        }
    }

    if (is.na(last_shot_time)) {
        return(NA)
    } else {
        return(shot_time - last_shot_time)
    }
}