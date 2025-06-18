import json
import os
import shutil



matches_source_folder     = "../analise-futebol/data/la_liga_matches"
events_source_folder      = "../StatsBomb-Data/open-data/data/events"
events_destination_folder = "data/events_la_liga"

ids    = []
team1 = []
team2 = []

for file_name in os.listdir(matches_source_folder):
    if file_name.endswith('.json'):
        file_path = os.path.join(matches_source_folder, file_name)
        
        with open(file_path, 'r', encoding='utf-8') as f:
            data = json.load(f)
        
        if isinstance(data, list):
            for i in range(len(data)):
                ids.append(data[i]['match_id'])
                team1.append(data[i]['home_team']['home_team_name'])
                team2.append(data[i]['away_team']['away_team_name'])
        elif isinstance(data, dict) and 'match_id' in data:
             ids.append(data['match_id'])
             team1.append(data['home_team']['home_team_name'])
             team2.append(data['away_team']['away_team_name'])



for i, file_id in enumerate(ids):
    filename = f"{file_id}.json"
    source_path = os.path.join(events_source_folder,filename)

    if os.path.exists(source_path):
        new_filename     = f"{team1[i]}_vs_{team2[i]}_{file_id}.json"
        destination_path = os.path.join(events_destination_folder, new_filename)

        shutil.copyfile(source_path, destination_path)

        print(f"Moved {filename} to {new_filename}")
    else:
        print(f"{ids[i]} not found")