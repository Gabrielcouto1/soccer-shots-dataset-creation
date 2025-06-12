source("./r/utils/xg/get_match_xg.r")

simulate_match_outcome <- function(home_team, away_team, n=10000){
    home_wins <- 0
    away_wins <- 0
    draws     <- 0

    for(i in 1:n){
        home_goals <- sum(rbinom(n = length(home_xg), size = 1, prob = home_xg))
    
        away_goals <- sum(rbinom(n = length(away_xg), size = 1, prob = away_xg))

        if (home_goals > away_goals) {
            home_wins <- home_wins + 1
        }else if (away_goals > home_goals){
            away_wins <- away_wins + 1
        }else{
            draws <- draws + 1
        }
    }

    home_prob <- home_wins / n
    away_prob <- away_wins / n
    draw_prob <- draws /n

    return(list(home_prob = home_prob, away_prob = away_prob, draw_prob = draw_prob))
}