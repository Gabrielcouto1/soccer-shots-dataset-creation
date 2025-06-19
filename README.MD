# Dataset Creation based on public data provided by StatsBomb

***

## Step by step to create the dataset from Statsbomb Open-data

```
git clone https://github.com/Gabrielcouto1/analise-futebol
```
```
git clone https://github.com/statsbomb/open-data/
```

```
cd analise-futebol/python/
```

```
python3 
```

***
## Data Dictionary

This table provides a detailed description of each column in the dataset.

| Column Name                 | Description                                                                                                                                 | Data Type         | Possible Values                                                                                  |
| :-------------------------- | :------------------------------------------------------------------------------------------------------------------------------------------ | :---------------- | :----------------------------------------------------------------------------------------------- |
| `competition`               | The league or competition the shot belongs to.                                                                                              | String            | e.g., 'Bundesliga', 'La Liga', 'Ligue 1', 'Premier league', 'Serie A'                            |
| `season`                    | The season in which the shot's match was played.                                                                                            | String            | e.g., '2015-2016', '2022-2023'                                                                   |
| `match_id`                  | A unique identifier for the match the shot was taken.                                                                                       | Integer           | Any unique integer.                                                                              |
| `attacking_team`            | The team that took the shot.                                                                                                                | String            | Name of a football team.                                                                         |
| `is_home`                   | Indicates if the attacking team is the home team.                                                                                           | Integer (Boolean) | `1` for home team, `0` for away team.                                                            |
| `defending_team`            | The team that is defending against the shot.                                                                                                | String            | Name of a football team.                                                                         |
| `shot_dist`                 | The distance the ball traveled from the place the shot was taken.                                                                           | Float             | Any positive floating-point number.                                                              |
| `dist_to_goal`              | The distance from the shot event to the goal line in meters.                                                                                | Float             | Any positive floating-point number.                                                              |
| `shot_angle`                | The angle of the shot in relation to the goal posts, in degrees. Check appendix A.                                                          | Float             | A float, typically between 0 and 180;.                                                           |
| `body_part`                 | The body part used to take the shot.                                                                                                        | String            | e.g., 'Right Foot', 'Left Foot', 'Head', 'Other'.                                                |
| `shot_technique`            | The technique used for the shot.                                                                                                            | String            | e.g., 'Backheel', 'Diving Header', 'Half Volley', 'Lob', 'Normal', 'Overhead Kick', 'Volley'.    |
| `shot_type`                 | The type of play leading to the shot.                                                                                                       | String            | e.g., 'Open Play', 'Penalty', 'Free Kick', 'Corner', 'Kick Off'.                                 |
| `teammates_in_frame`        | The number of teammates visible in the frame when the shot was taken.                                                                       | Integer           | Any non-negative integer.                                                                        |
| `opponents_in_frame`        | The number of opponents visible in the frame when the shot was taken.                                                                       | Integer           | Any non-negative integer.                                                                        |
| `closest_opponent_dist`     | The distance to the closest opponent at the time of the shot in meters.                                                                     | Float             | Any positive floating-point number.                                                              |
| `goalkeeper_dist`           | The distance of the goalkeeper from the shot location in meters.                                                                            | Float             | Any positive floating-point number.                                                              |
| `opponents_in_penalty_area` | The number of opponents inside the penalty area.                                                                                            | Integer           | Any non-negative integer.                                                                        |
| `opponents_in_goal_area`    | The number of opponents inside the goal area.                                                                                               | Integer           | Any non-negative integer.                                                                        |
| `opponents_in_shot_path`    | The number of opponents inside the triangle traced from the place the shot was taken and the two goal posts. Check appendix B.              | Integer           | Any non-negative integer.                                                                        |
| `is_penalty`                | Indicates if the shot was a penalty.                                                                                                        | Integer (Boolean) | `1` for yes, `0` for no.                                                                         |
| `statsbomb_xg`              | The Expected Goals (xG) provided by Statsbomb. This represents the probability of a shot resulting in a goal based on historical data.      | Float             | A float between 0 and 1.                                                                         |
| `outcome`                   | The outcome, result of the shot.                                                                                                            | String            | e.g., 'Blocked', 'Goal', 'Off T', 'Post', 'Saved', 'Wayward', 'Saved Off T', 'Saved To Post'.    |
| `is_goal`                   | Indicates if the shot resulted in a goal.                                                                                                   | Integer (Boolean) | `1` for a goal, `0` for no goal.                                                                 |