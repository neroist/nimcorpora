import std/strformat
import std/strutils
import std/sugar
import std/json
import std/os

import nimcorpora/install
import nimcorpora/private/common


type
  Corpora* = ref object


using
  corpora: Corpora

func newCorpora*(): Corpora =
  ## Get a new Corpora object. Needed to access Corpora data.
  ## Instead of this proc, you could also use `new Corpora` instead.

  new result


# --- categories ---

proc getCategories*(corpora): seq[string] =
  setDataVar()

  ## Get all categories (directories) in the Corpora data.
  for dir in walkDirRec(data, yieldFilter={pcDir}, relative=true):
    # if a dir has no json files in it, do not include it in the result
    if collect(for file in walkFiles(fmt"{data / dir}/*.json"): file).len != 0:
      result.add dir

proc categories*(corpora): seq[string] =
  ## Alias for `getCategories <#getCategories,Corpora>`_

  getCategories(corpora)

# --- subcategories ---

proc getSubcategories*(corpora): seq[string] =
  ## Get all subcategories (a.k.a the json files in the data) under all categories
  setDataVar()

  for file in walkDirRec(data): 
    result.add file.split(DirSep)[^2..^1].join($DirSep).changeFileExt("")

proc getSubcategories*(corpora; category: string): seq[string] =
  ## Get all subcategories under `category`
  setDataVar()

  for file in walkDirRec(data / category): 
    result.add file.split(DirSep)[^2..^1].join($DirSep).changeFileExt("")

proc getSubcategories*(corpora; categories: openArray[string]): seq[seq[string]] =
  ## Get all subcategories under `categories`

  for category in categories: result.add corpora.getSubcategories(category)

proc subcategories*(corpora): seq[string] =
  ## Alias for `getSubcategories <#getSubcategories,Corpora>`_

  getSubcategories(corpora)

# --- retreive data ---

proc getFile*(corpora; path: string): JsonNode =
  ## Get a file by its path. Input `path` as subcategory (e.x "animals/ant_anatomy")
  setDataVar()

  parseFile(data / path.changeFileExt(".json"))

proc getFile*(corpora; category, subcategory: string): JsonNode =
  ## Get a file by its category and subcategory

  corpora.getFile(category / subcategory)

proc getFiles*(corpora; paths: openArray[string]): seq[JsonNode] =
  ## Get multiple files by their paths.

  for path in paths: result.add corpora.getFile(path)

proc getFiles*(corpora; category: string): seq[JsonNode] =
  ## Get all files under `category`

  for subcategory in corpora.getSubcategories(category): 
    result.add corpora.getFile(subcategory)

proc getFilesByCategories*(corpora; categories: openArray[string]): seq[seq[JsonNode]] =
  ## Get all files under `categories`.

  for category in categories: result.add corpora.getFiles(category)

proc getFiles*(corpora; category: string; subcategories: openArray[
    string]): seq[JsonNode] =
  ## Get multiple files from `subcategories` under `category`

  for subcategory in subcategories: result.add corpora.getFile(category / subcategory)

# --- update/reinstall data ---

proc update*(corpora; output: bool = off) =
  ## Update Corpora data

  when defined(release):
    installCorporaData(getCurrentDir().parentDir, output)
  else:
    installCorporaData(currentSourcePath().parentDir(), output)

export installCorporaData
