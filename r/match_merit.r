source("./r/utils/xg/simulate_match_outcome.r")

home_team <- "Argentina"
away_team <- "Canada"
match <- paste0(home_team, "_vs_", away_team)

match_xg <- get_match_xg(match)

home_xg <- match_xg$home_xg
away_xg <- match_xg$away_xg

outcome_probability <- simulate_match_outcome(home_xg, away_xg)

print(outcome_probability)