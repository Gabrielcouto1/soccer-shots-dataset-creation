source("./r/utils/plot/get_distance.r")

get_teammate_count <- function(shot){
    teammate_count <- 0

    for(i in 1:length(shot$shot$freeze_frame)){
        if (shot$shot$freeze_frame[[i]]$teammate == TRUE){
            teammate_count <- teammate_count + 1
        }
    }
    return(teammate_count)
}

get_enemy_count <- function(shot){
    enemy_count <- 0

    for(i in 1:length(shot$shot$freeze_frame)){
        if (shot$shot$freeze_frame[[i]]$teammate == FALSE){
            enemy_count <- enemy_count + 1
        }
    }
    return(enemy_count)
}

get_closest_enemy_distance <- function(shot){
    closest_distance <- Inf

    for(i in 1:length(shot$shot$freeze_frame)) {
        if (shot$shot$freeze_frame[[i]]$teammate == FALSE) {
            current_distance <- get_distance(shot$location, shot$shot$freeze_frame[[i]]$location)

            if (current_distance < closest_distance){
                closest_distance <- current_distance
            }
        }
    }
    return(closest_distance)
}

get_goalkeeper_distance <- function(shot){
    for(i in 1:length(shot$shot$freeze_frame)) {
        if (shot$shot$freeze_frame[[i]]$teammate == FALSE && shot$shot$freeze_frame[[i]]$position$id == 1 ) {
            return(get_distance(shot$location, shot$shot$freeze_frame[[i]]$location))
        }
    }
}

get_enemies_count_in_area <- function(shot){
    goal_area_count    <- 0
    penalty_area_count <- 0
    
    for(i in 1:length(shot$shot$freeze_frame)) {
        if (shot$shot$freeze_frame[[i]]$teammate == FALSE) {
            x <- shot$shot$freeze_frame[[i]]$location[1]
            y <- shot$shot$freeze_frame[[i]]$location[2]

            is_in_penalty_area <- (x >= 102 && x <= 120) && (y >= 18 && y <= 62)
            is_in_goal_area    <- (x >= 114 && x <= 120) && (y >= 30 && y <= 50)

            if (is_in_penalty_area) {
                penalty_area_count <- penalty_area_count + 1
            }
            if (is_in_goal_area) {
                goal_area_count <- goal_area_count + 1
            }
        }
    }

    return(list(penalty_area_count=penalty_area_count,
                goal_area_count=goal_area_count))
}

cross_product_2d <- function(a, b, c){
    # Returns > 0 if C is to the left of vector AB
    # Returns < 0 if C is to the right of vector AB
    # Returns = 0 if A, B, and C are collinear
    return((b[1] - a[1]) * (c[2] - a[2]) - (b[2] - a[2]) * (c[1] - a[1]))
}

get_enemies_in_ball_trajectory <-function(shot){
    shot_location <- shot$location 
    post_1 <- c(120, 36)
    post_2 <- c(120, 44)

    enemies_count <- 0
    for(i in 1:length(shot$shot$freeze_frame)) {
        player <- shot$shot$freeze_frame[[i]]
        if (player$teammate == FALSE){
            player_location <- player$location

            # side_1 is the line going from shot_location to post_1
            side_1 <- cross_product_2d(shot_location, post_1, player_location)

            # side_2 is the line going from post_1 to post_2
            side_2 <- cross_product_2d(post_1, post_2, player_location)

            # side_3 is the line going from shot_location to post_2
            side_3 <- cross_product_2d(post_2, shot_location, player_location)

            is_inside <- (side_1>=0 && side_2>=0 && side_3>=0) ||
                         (side_1<=0 && side_2<=0 && side_3<=0)

            if(is_inside){
                enemies_count <- enemies_count + 1
            }
        }
    }

    return(enemies_count)
}