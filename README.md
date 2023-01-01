# nimcorpora
A Nim interface for Darius Kazemi's [Corpora](https://github.com/dariusk/corpora) project. - [**Documentation**](https://neroist.github.io/nimcorpora/nimcorpora.html)

Inspired by [pycorpora](https://github.com/aparrish/pycorpora).

## Installation 
Since at the moment nimcorpora is not on nimble you can install it by its Github or Git link:

```
nimble install https://github.com/neroist/nimcorpora
```

or 

```
nimble install https://github.com/neroist/nimcorpora.git
```

After installation, Corpora's data will be installed to the packages's directory. If this fails for whatever reason, [report an error](https://github.com/neroist/nimcorpora/issues/new) and install and put the data in the `data/` directory in the package directory.

## Documentation
See https://neroist.github.io/nimcorpora/nimcorpora.html

## Example/Showcase
```nim
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
```

Additional examples available at [`examples/`](/examples)


## Distribution
For distributing an application, make sure the directory containing Corpora's data is **neighboring the directory of the executable**

So, the preferred file structure for distributing is:
```
your_application/
  bin/
    your_executable
    ...
    
  data/
    ...
```

To install the data there, you can either use `installCorporaData()` or include the data by default in you application directory

In addition, `update()`, by default, updates the data in the package's directory. When compiling a release build, `update()` instead updates the data in the `data/` directory. So, make sure to compile with `-d:release` when distributing so `update()` works correctly for distributing.

###### Made with ❤️ with Nim
