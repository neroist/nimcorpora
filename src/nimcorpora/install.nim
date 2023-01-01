## Script for installing corpora data. This is run after package installation
## and also functions as a submodule

import std/httpclient
import std/strutils
import std/os

import zippy/ziparchives
import fab

template withDir(dir: string, body: untyped): untyped =
  let cwd = getCurrentDir()
  setCurrentDir dir

  body

  setCurrentDir cwd

proc installCorporaData*(dir: string = getCurrentDir(); output: bool = on) =
  ## Installs Corpora data into `dir`. `output` control's whether or not to 
  ## display output. `false` for no output, `true` for output
  
  withDir dir:
    # download zip file
    if output: info("Dowloading Corpora data...")

    var client = newHttpClient()
    client.downloadFile(
      "https://github.com/dariusk/corpora/archive/refs/heads/master.zip",
      "./corpora.zip"
    )

    if output: good("Downloaded data!\n")

    # extract needed files
    block: #* block needed for "defer" statement
      if output: info("Extracting Corpora data...")

      var files: seq[string]

      let reader = openZipArchive("./corpora.zip")
      defer:
        # close reader and delete zip file when done
        reader.close()
        removeFile("./corpora.zip")

        if output: good("Extracted data!")

      for file in reader.walkFiles:
        # package.json is not apart of the data; we dont want that file
        if splitPath(file).tail == "package.json": continue

        # all data is in json files
        if splitFile(file).ext == ".json":
          files.add file

      for file in files:
        # we use "file.tailDir" to get rid of the unnecessary
        # "corpora-master" dir in the file path

        # we need to create directories so we can write the extracted
        # data to them later. `writeFile` throws an error when we don't

        # creates only the data/... directories
        let dir = splitPath(file.tailDir).head

        if not dirExists(dir):
          createDir(dir)

        writeFile(file.tailDir, reader.extractFile(file))
        #good("Extracted " & file.tailDir)

when isMainModule:
  installCorporaData()
