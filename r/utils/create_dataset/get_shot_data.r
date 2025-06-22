library("rjson") 

source("./r/utils/plot/get_distance.r")
source("./r/utils/create_dataset/get_goal_angle.r")
source("./r/utils/create_dataset/freeze_frame.r")
source("./r/utils/get_related_event.r")

get_shot_data <- function(shot, home_team, away_team, competition_name=competition_name, season=season, match_id=match_id, match_json){
    
    
    # Team and Match Context
    attacking_team <- shot$possession_team$name
    is_home        <- ifelse(attacking_team == home_team, 1, 0)
    defending_team <- ifelse(is_home == 1, away_team, home_team)
    
    # Time and period related characteristics
    timestamp <- (shot$minute * 60) + shot$second
    period    <- shot$period
    
    # Shot characteristics
    shooter_position <- shot$position$name
    shot_technique   <- shot$shot$technique$name
    body_part        <- shot$shot$body_part$name
    shot_type        <- shot$shot$type$name
    
    # Spatial and Geometric Features
    source       <- shot$location
    destination  <- shot$shot$end_location
    shot_dist    <- get_distance(source, destination)
    dist_to_goal <- get_distance(source, c(120, 40))
    shot_angle   <- get_goal_angle(source)
    
    # Situational Flags
    is_from_cross <- 0
    is_under_pressure <- 0
    key_pass <- NULL
    
    if(!is.null(shot$shot$key_pass_id)){
        key_pass <- get_related_event(shot$shot$key_pass_id, match_json)
    }

    if (!is.null(key_pass)) {
        is_from_cross <- as.integer(!is.null(key_pass$pass$cross))
        is_under_pressure <- as.integer(!is.null(key_pass$under_pressure))
    }

    is_ca             <- ifelse(shot$play_pattern$name == "From Counter", 1, 0)
    is_penalty        <- ifelse(shot$shot$type$id == 88,                  1, 0)
    is_open_goal      <- ifelse(!is.null(shot$shot$open_goal),            1, 0)
    is_first_time     <- ifelse(!is.null(shot$shot$first_time),           1, 0)
    is_one_on_one     <- ifelse(!is.null(shot$shot$one_on_one),           1, 0)
    is_aerial_win     <- ifelse(!is.null(shot$shot$aerial_won),           1, 0)

    # Freeze Frame Analysis (player in frame locations)
    if (is_penalty == 1) {
        teammates_in_frame        <- 0
        opponents_in_frame        <- 0
        closest_opponent_dist     <- 0
        goalkeeper_dist           <- 0
        opponents_in_penalty_area <- 0
        opponents_in_goal_area    <- 0
        opponents_in_shot_path    <- 0
    } else {
        enemies_in_area           <- get_enemies_count_in_area(shot)
        teammates_in_frame        <- get_teammate_count(shot)
        opponents_in_frame        <- get_enemy_count(shot)
        closest_opponent_dist     <- get_closest_enemy_distance(shot)
        goalkeeper_dist           <- get_goalkeeper_distance(shot)
        opponents_in_penalty_area <- enemies_in_area$penalty_area_count
        opponents_in_goal_area    <- enemies_in_area$goal_area_count
        opponents_in_shot_path    <- get_enemies_in_ball_trajectory(shot)
    }
    goalkeeper_position <- NA # it's NA if the goalkeeper is not present in the shot
    
    for(id in shot$related_events){
        event <- get_related_event(id, match_json)
        if(!is.null(event$type$name) && event$type$name=="Goal Keeper"){
            goalkeeper_position <- event$goalkeeper$position$name
            break
        }
    }

    # Shot Outcome
    statsbomb_xg <- shot$shot$statsbomb_xg
    outcome      <- shot$shot$outcome$name
    is_goal      <- ifelse(shot$shot$outcome$id == 97, 1, 0)
    
    return(list(
        competition = competition_name,
        season = season,
        match_id = match_id,
        timestamp = timestamp,
        period = period,
        attacking_team = attacking_team,
        defending_team = defending_team,
        is_home = is_home,
        shooter_position = shooter_position,
        shot_dist = shot_dist,
        dist_to_goal = dist_to_goal,
        shot_angle = shot_angle,
        body_part = body_part,
        shot_technique = shot_technique,
        shot_type = shot_type,
        is_ca = is_ca,
        is_from_cross = is_from_cross,
        is_under_pressure = is_under_pressure,
        is_penalty = is_penalty,
        is_open_goal = is_open_goal,
        is_first_time = is_first_time,
        is_one_on_one = is_one_on_one,
        is_aerial_win = is_aerial_win,
        teammates_in_frame = teammates_in_frame,
        opponents_in_frame = opponents_in_frame,
        closest_opponent_dist = closest_opponent_dist,
        goalkeeper_dist = goalkeeper_dist,
        goalkeeper_position = goalkeeper_position,
        opponents_in_penalty_area = opponents_in_penalty_area,
        opponents_in_goal_area = opponents_in_goal_area,
        opponents_in_shot_path = opponents_in_shot_path,
        statsbomb_xg = statsbomb_xg,
        outcome = outcome,
        is_goal = is_goal
    ))
}