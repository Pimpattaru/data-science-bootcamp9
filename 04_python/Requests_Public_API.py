# Homework01
# requests pull data from public API
# write data to csv file

from requests import get
from time import sleep
import csv

url = "https://swapi.dev/api/people/"

# Open the CSV file for writing
with open("star_wars_people.csv", "w", newline="") as csvfile:
  # Create CSV writer object
  writer = csv.writer(csvfile)

  # Write header row
  writer.writerow(["Name", "Height", "Mass", "Gender", "Homeworld"])

  ## homework API 01
  for i in range(5):
      index = i + 1
      new_url = url + str(index)
      resp = get(new_url).json()
      name = resp["name"]
      height = resp["height"]
      mass = resp["mass"]
      gender = resp["gender"]
      homeworld = resp["homeworld"]
      print(name, height, mass, gender, homeworld)
      sleep(1)

      # Write data row to CSV
      writer.writerow([name, height, mass, gender, homeworld])

  print("Data exported to star_wars_people.csv")

# Homework02
# requests pull data from public API
response = requests.get('http://makeup-api.herokuapp.com/api/v1/products.json')

if response.status_code == 200:
    data = response.json()
    print(data)
else:
    print("Error:", response.staus.code)

response.headers["Content-Type"]
response.json()
