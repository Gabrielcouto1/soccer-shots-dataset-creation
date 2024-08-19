import json, math

data = json.load(open("../data/events_copa_america_24/Argentina_vs_Canada.json"))


print( data[4])

if data[4]['play_pattern']['id'] == 9:
    print(f'Start location: {data[4]["location"]}')
    print(f'End location: {data[4]["pass"]["end_location"]}')
    
distance = math.sqrt((data[4]["pass"]["end_location"][0] - data[4]["location"][0])**2 + (data[4]["pass"]["end_location"][1] - data[4]["location"][1])**2)

# Print the result
print(f"The distance between the points is: {distance}")