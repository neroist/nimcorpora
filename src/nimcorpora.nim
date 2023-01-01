import std/json
import std/os

import nimcorpora/install

type
  Corpora* = ref object

func tailTailDir(dir: string): string {.inline.} = dir.tailDir.tailDir


proc newCorpora*(): Corpora =
  ## Get a new Corpora object. Needed to access Corpora data.

  new result

# --- categories ---

proc getCategories*(_: Corpora): seq[string] =
  ## Get all categories (directories) in the Corpora data.

  for dir in walkDirs("../data/*"): result.add dir.tailTailDir

proc categories*(_: Corpora): seq[string] =
  ## Alias for `getCategories <#getCategories,Corpora>`_

  getCategories(_)

# --- subcategories ---

proc getSubcategories*(_: Corpora): seq[string] =
  ## Get all subcategories (a.k.a the json files in the data) under all categories

  for file in walkDirRec("../data"): result.add file.tailTailDir().changeFileExt("")

proc getSubcategories*(_: Corpora; category: string): seq[string] =
  ## Get all subcategories under `category`

  for file in walkDirRec("../data" / category): result.add file.tailTailDir().changeFileExt("")

proc getSubcategories*(_: Corpora; categories: openArray[string]): seq[seq[string]] =
  ## Get all subcategories under `categories`

  for category in categories: result.add _.getSubcategories(category)

proc subcategories*(_: Corpora): seq[string] =
  ## Alias for `getSubcategories <#getSubcategories,Corpora>`_

  getSubcategories(_)

# --- retreive data ---

proc getFile*(_: Corpora; path: string): JsonNode =
  ## Get a file by its path. Input `path` as subcategory (e.x "animals/ant_anatomy")

  parseFile("../data" / path.changeFileExt(".json"))

proc getFile*(_: Corpora; category, subcategory: string): JsonNode =
  ## Get a file by its category and subcategory

  _.getFile(category / subcategory)

proc getFiles*(_: Corpora; paths: openArray[string]): seq[JsonNode] =
  ## Get multiple files by their paths.

  for path in paths: result.add _.getFile(path)

proc getFiles*(_: Corpora; category: string): seq[JsonNode] =
  ## Get all files under `category`

  for subcategory in _.getSubcategories(category): result.add _.getFile(subcategory)

proc getFilesByCategories*(_: Corpora; categories: openArray[string]): seq[seq[JsonNode]] =
  ## Get all files under `categories`.

  for category in categories: result.add _.getFiles(category)

proc getFiles*(_: Corpora; category: string; subcategories: openArray[
    string]): seq[JsonNode] =
  ## Get multiple files from `subcategories` under `category`

  for subcategory in subcategories: result.add _.getFile(category / subcategory)

# --- update/reinstall data ---

proc update*(_: Corpora; output: bool = off) =
  ## Update Corpora data

  when defined(release):
    updateRelease(_, output)
  else:
    installCorporaData(currentSourcePath().parentDir(), output)

export installCorporaData