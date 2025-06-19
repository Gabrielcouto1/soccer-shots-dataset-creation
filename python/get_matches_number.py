import json
import os

events_source_folder      = "../..//open-data/data/events"
events_destination_folder = "data/events_la_liga"

import os
import json

for competition_id in range(1472):
    matches_source_folder = f"../../open-data/data/matches/{competition_id}"

    if os.path.exists(matches_source_folder) and os.path.isdir(matches_source_folder):
        ids = []
        team1 = []
        team2 = []
        competition_name = ""  

        for file_name in os.listdir(matches_source_folder):
            if file_name.endswith('.json'):
                file_path = os.path.join(matches_source_folder, file_name)

                with open(file_path, 'r', encoding='utf-8') as f:
                    try:
                        data = json.load(f)
                        if data: 
                            if isinstance(data, list) and data[0]['competition']['competition_name']:
                                competition_name = data[0]['competition']['competition_name']

                            if isinstance(data, list):
                                for item in data:
                                    ids.append(item['match_id'])
                                    team1.append(item['home_team']['home_team_name'])
                                    team2.append(item['away_team']['away_team_name'])
                            elif isinstance(data, dict) and 'match_id' in data:
                                ids.append(data['match_id'])
                                team1.append(data['home_team']['home_team_name'])
                                team2.append(data['away_team']['away_team_name'])
                                if 'competition' in data and 'competition_name' in data['competition']:
                                    competition_name = data['competition']['competition_name']

                    except json.JSONDecodeError:
                        print(f"Warning: Could not decode JSON from {file_name}")
                    except (KeyError, IndexError) as e:
                        print(f"Warning: Missing expected data in {file_name}: {e}")


        if ids:  
            print(f"--------Competition {competition_id} ({competition_name})--------")
            print(f"Matches: {len(ids)}")