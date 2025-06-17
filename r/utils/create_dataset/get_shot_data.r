library("rjson") 

source("./r/utils/plot/get_distance.r")
source("./r/utils/create_dataset/get_goal_angle.r")
source("./r/utils/create_dataset/freeze_frame.r")

get_shot_data <- function(shot){
    source      <- shot$location
    destination <- shot$shot$end_location
    
    shot_length   <- get_distance(source, destination)
    goal_distance <- get_distance(source, c(120,40))
    goal_angle    <- get_goal_angle(source)

    body_part      <- shot$shot$body_part$id
    body_part_name <- shot$shot$body_part$name

    technique      <- shot$shot$technique$id
    technique_name <- shot$shot$technique$name

    type      <- shot$shot$type$id
    type_name <- shot$shot$type$name

    teammate_count <- get_teammate_count(shot)
    enemy_count    <- get_enemy_count(shot)

    closets_enemy_distance <- get_closest_enemy_distance(shot)
    
    gk_distance <- get_goalkeeper_distance(shot)

    return(list(shot_length=shot_length,
                goal_distance=goal_distance,
                goal_angle=goal_angle,
                body_part=body_part,
                body_part_name=body_part_name,
                technique=technique,
                technique_name=technique_name, 
                type=type,
                type_name=type_name,
                teammate_count=teammate_count,
                enemy_count=enemy_count,
                closets_enemy_distance=closets_enemy_distance,
                gk_distance=gk_distance))
}