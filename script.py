import json

# Load the JSON data from the file
with open('sources.json', 'r') as file:
    data = json.load(file)

# List to hold the names of dependencies meeting the criteria
valid_dependencies = []

# Iterate through each dependency in the data
for dependency in data:
    # Check if 'os' is not a key or if 'linux' is in the 'os' field
    if 'os' not in dependency or 'linux' in dependency['os']:
        valid_dependencies.append(dependency['name'])

with open('valid_dependencies.txt', 'w') as file:
    for name in valid_dependencies:
        file.write(name + '\n')

