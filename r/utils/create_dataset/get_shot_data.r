library("rjson") 

source("./r/utils/plot/get_distance.r")
source("./r/utils/create_dataset/get_goal_angle.r")

get_shot_data <- function(shot){
    source      <- shot$location
    destination <- shot$shot$end_location
    
    shot_length   <- get_distance(source, destination)
    goal_distance <- get_distance(source, c(120,40))

    goal_angle <- get_goal_angle(source)

    body_part <- shot$shot$body_part$id
    body_part_name <- shot$shot$body_part$name

    technique <- shot$shot$technique$id
    technique_name <- shot$shot$technique$name

    type <- shot$shot$type$id
    type_name <- shot$shot$type$name

    

    return(list(shot_length=shot_length,
                goal_distance=goal_distance,
                goal_angle=goal_angle,
                body_part=body_part,
                body_part_name=body_part_name,
                technique=technique,
                technique_name=technique_name, 
                type=type,
                type_name=type_name))
}