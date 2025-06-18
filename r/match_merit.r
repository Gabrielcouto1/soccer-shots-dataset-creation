source("./r/utils/xg/simulate_match_outcome.r")
source("./r/utils/plot/plot_gauge_chart.r")
source("./r/utils/get_match_json.r")

competition <- "copa_america_24"

match_json <- get_match_json("Argentina", "Canada", competition)
match_xg <- get_match_xg(match_json)

home_xg <- match_xg$home_xg
away_xg <- match_xg$away_xg

outcome_prob <- simulate_match_outcome(home_xg, away_xg)

print(outcome_prob)

plot_gauge_chart(outcome_prob$home_prob, outcome_prob$draw_prob, outcome_prob$away_prob, home_team, away_team, competition)