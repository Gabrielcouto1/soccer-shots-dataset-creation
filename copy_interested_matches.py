import json
import os
import shutil

# Get the desired matches IDs and teams
file = open("data/copa_america_24_matches.json")
data = json.load(file)

ids    = []
team1 = []
team2 = []

for i in range(len(data)):
    ids.append(data[i]['match_id'])
    team1.append(data[i]['home_team']['home_team_name'])
    team2.append(data[i]['away_team']['away_team_name'])


# Move and rename the match files containing each event
source_folder      = "../StatsBomb-Data/open-data/data/events"
destination_folder = "data/events_copa_america_24"

for i, file_id in enumerate(ids):
    filename = f"{file_id}.json"
    source_path = os.path.join(source_folder,filename)

    if os.path.exists(source_path):
        new_filename     = f"{team1[i]}_vs_{team2[i]}.json"
        destination_path = os.path.join(destination_folder, new_filename)

        shutil.copyfile(source_path, destination_path)

        print(f"Moved {filename} to {new_filename}")
    else:
        print(f"{ids[i]} not found")