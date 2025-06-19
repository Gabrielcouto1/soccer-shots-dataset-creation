import json
import os
import shutil

competition = "bundesliga"
competition_name = "Bundesliga"

# competition = "la_liga"
# competition_name = "La Liga"

# competition = "ligue_1"
# competition_name = "Ligue 1"

# competition = "premier_league"
# competition_name = "Premier League"

# competition = "serie_a"
# competition_name = "Serie A"

matches_source_folder   = f"../../analise-futebol/data/matches_list/{competition}_matches"
events_source_folder    = "../../StatsBomb-Data/open-data/data/events"
events_destination_folder = f"../data/events/events_{competition}"

os.makedirs(events_destination_folder, exist_ok=True)

for file_name in os.listdir(matches_source_folder):
    if file_name.endswith('.json'):
        season = os.path.splitext(file_name)[0]
        
        file_path = os.path.join(matches_source_folder, file_name)
        
        with open(file_path, 'r', encoding='utf-8') as f:
            matches_in_season = json.load(f)
        
        for match in matches_in_season:
            match_id = match['match_id']
            team1 = match['home_team']['home_team_name']
            team2 = match['away_team']['away_team_name']

            source_event_path = os.path.join(events_source_folder, f"{match_id}.json")

            if os.path.exists(source_event_path):
                with open(source_event_path, 'r', encoding='utf-8') as f_event:
                    event_data = json.load(f_event)
                
                if isinstance(event_data, list) and len(event_data) > 0:
                    event_data[0]['competition_name'] = competition_name
                    event_data[0]['season'] = season
                    event_data[0]['match_id'] = str(match_id)
                
                new_filename = f"{team1}_vs_{team2}_{match_id}.json"
                destination_path = os.path.join(events_destination_folder, new_filename)

                with open(destination_path, 'w', encoding='utf-8') as f_dest:
                    json.dump(event_data, f_dest, ensure_ascii=False, indent=4)

                print(f"Processed and moved {match_id}.json to {new_filename}")
            else:
                print(f"Event file for match_id {match_id} not found")