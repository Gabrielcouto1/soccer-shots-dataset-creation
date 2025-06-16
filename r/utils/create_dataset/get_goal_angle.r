source("./r/utils/plot/get_distance.r")

get_goal_angle <- function(shot_location){
    # Law of cosines:
    # a^2 = b^2 + c^2 - 2*b*c * cos(alpha)
    
    # To get cos(alpha):
    # cos(alpha) = (b^2 + c^2 - a^2) / 2*b*c

    # Consider that: 
    # a is the goal width
    # b is the distance between the shot_location and one of the goal posts
    # c is the distance between the shot_loaction and the other goal post

    a <- 8
    b <- get_distance(shot_location, c(120,36))
    c <- get_distance(shot_location, c(120,44))

    cos_alpha <- (b^2 + c^2 - a^2) 
    cos_alpha <- cos_alpha / (2*b*c)

    alpha <- acos(cos_alpha) * 180 /pi

    return(alpha)
}