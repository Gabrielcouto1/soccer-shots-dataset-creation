source("./r/utils/get_match_xg.r")

home_team <- "Argentina"
away_team <- "Canada"

match <- paste0(home_team, "_vs_", away_team)

match_xg <- get_match_xg(match)

print(sum(match_xg$home_xg))
print(sum(match_xg$away_xg))