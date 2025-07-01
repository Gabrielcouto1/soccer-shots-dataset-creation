source("./r/utils/create_dataset/create_csvs.r")
source("./r/utils/check_libraries.r")

check_libraries()

competitions <- c("bundesliga", "la_liga", "ligue_1", "premier_league", "serie_a")
create_csvs(competitions)
    