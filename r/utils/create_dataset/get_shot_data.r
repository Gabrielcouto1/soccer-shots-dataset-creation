library("rjson") 

source("./r/utils/plot/get_distance.r")
source("./r/utils/create_dataset/get_goal_angle.r")

get_shot_data <- function(shot){
    source      <- shot$location
    destination <- shot$shot$end_location
    
    shot_length   <- get_distance(source, destination)
    goal_distance <- get_distance(source, c(120,40))

    goal_angle <- get_goal_angle(source)




    return(list(source=source, 
                destination=destination,    
                shot_length=shot_length,
                goal_distance=goal_distance,
                goal_angle=goal_angle))
}