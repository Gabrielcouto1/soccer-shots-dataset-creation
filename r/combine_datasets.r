library(tidyverse)

csv_files <- c(
  "./datasets/serie_a_shots.csv",
  "./datasets/premier_league_shots.csv",
  "./datasets/bundesliga_shots.csv",
  "./datasets/la_liga_shots.csv",
  "./datasets/ligue_1_shots.csv"
)

combined_df <- map_dfr(csv_files, read_csv)
write_csv(combined_df, "./datasets/shots.csv")