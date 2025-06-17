library("rjson") 

source("./r/utils/plot/get_distance.r")
source("./r/utils/create_dataset/get_goal_angle.r")
source("./r/utils/create_dataset/freeze_frame.r")

get_shot_data <- function(shot){
    source       <- shot$location
    destination  <- shot$shot$end_location
    shot_dist    <- get_distance(source, destination)
    dist_to_goal <- get_distance(source, c(120,40))
    shot_angle   <- get_goal_angle(source)

    shot_technique <- shot$shot$technique$name
    body_part      <- shot$shot$body_part$name
    shot_type      <- shot$shot$type$name

    teammates_in_frame <- get_teammate_count(shot)
    opponents_in_frame <- get_enemy_count(shot)

    closest_opponent_dist <- get_closest_enemy_distance(shot)
    
    goalkeeper_dist <- get_goalkeeper_distance(shot)

    enemies_in_area <- get_enemies_count_in_area(shot)

    opponents_in_penalty_area <- enemies_in_area$penalty_area_count
    opponents_in_goal_area <- enemies_in_area$goal_area_count

    opponents_in_shot_path <- get_enemies_in_ball_trajectory(shot)

    if(shot$shot$outcome$id==97){
        is_goal <- 1
    }else{
        is_goal <- 0
    }

    return(list(shot_dist=shot_dist,
                dist_to_goal=dist_to_goal,
                shot_angle=shot_angle,
                body_part=body_part,
                shot_technique=shot_technique, 
                shot_type=shot_type,
                teammates_in_frame=teammates_in_frame,
                opponents_in_frame=opponents_in_frame,
                closest_opponent_dist=closest_opponent_dist,
                goalkeeper_dist=goalkeeper_dist,
                opponents_in_penalty_area=opponents_in_penalty_area,
                opponents_in_goal_area=opponents_in_goal_area,
                opponents_in_shot_path=opponents_in_shot_path,
                is_goal=is_goal))
}