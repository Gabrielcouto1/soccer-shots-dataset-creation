import json
import os

events_source_folder       = "../..//open-data/data/events"

competitions = ["bundesliga", "la_liga", "ligue_1", "premier_league", "serie_a"]

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
                                season           = data[0]['season']['season_name'].replace("/","-")
                                
                                if competition_name == "1. Bundesliga":
                                    competition_name = "bundesliga"
                                else:
                                    competition_name = competition_name.replace(" ", "_")
                                    competition_name = competition_name.lower()
                                
                                if competition_name in competitions and season != "1973-1974":    
                                    matches_destination_folder = f"../data/matches_list/{competition_name}_matches"
                                    os.makedirs(matches_destination_folder, exist_ok=True)
                                    
                                    file_destination_path = os.path.join(matches_destination_folder, f"{season}.json")
                                    with open(file_destination_path, 'w', encoding='utf-8') as f_dest:
                                        json.dump(data, f_dest, ensure_ascii=False, indent=4)

                    except json.JSONDecodeError:
                        print(f"Warning: Could not decode JSON from {file_name}")
                    except (KeyError, IndexError) as e:
                        print(f"Warning: Missing expected data in {file_name}: {e}")
