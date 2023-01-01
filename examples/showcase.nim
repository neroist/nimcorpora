# ugly output, this file is just needed to show available procs

import std/json

import nimcorpora

# Get corpora object (needed to access data)
let corpora = newCorpora()

# Get all categories (aka directories in the data)
echo corpora.getCategories()
echo corpora.categories # or you can do it like this

# Get all subcategories (aka the json files in the data)
echo corpora.getSubcategories()
echo corpora.subcategories # or you can do it like this aswell
echo corpora.getSubcategories("animals") # you can also get all subcategories under
                                         # a specific category (e.g. animals)
echo corpora.getSubcategories(["animals", "archetypes"]) # or you could get all subcategories under
                                                         # under MULTIPLE categories mwuahahaha >:)

# get file (subcategory) contents
#* input `path` as subcategory (e.x "animals/ant_anatomy")
#* Note that these procs return a JsonNode
echo pretty corpora.getFile("animals/ant_anatomy")
echo pretty corpora.getFile("animals", "ant_anatomy") # you can also put the category
                                               # and subcateory as different params

# you can also get multiple files at once, via category and subcategory names
for file in corpora.getFiles("animals", ["ant_anatomy", "birds_antarctica"]):
  echo pretty file

# or you could get multiple files via their paths
for file in corpora.getFiles(["animals/birds_north_america", "animals/cats"]):
  echo pretty file

# or under a specific category
for file in corpora.getFiles("archetypes"):
  echo pretty file

# or even under multiple categories
for category in corpora.getFilesByCategories(["architecture", "art"]):
  for file in category:
    echo pretty file

# Update data
# This updates the data downloaded when nimcorpora was first installed 
echo "Updating Corpora data..."
corpora.update(output = on) #* -d:ssl needed for this proc!

echo "" # spacing

# Install data
# Installs Corpora data into current directory
echo "Installing Corpora data..."
installCorporaData() #* -d:ssl needed for this proc aswell!