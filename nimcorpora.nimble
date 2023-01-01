# Package

version       = "0.1.0"
author        = "Jasmine"
description   = "A Nim interface for Darius Kazemi's Corpora Project."
license       = "0BSD"
srcDir        = "src"
skipDirs      = @["examples"]


# Tasks

after install:
  echo "\nInstalling Corpora data..."
  selfExec"r ./nimcorpora/install.nim"

# Dependencies

requires "nim >= 1.6.10"
requires "zippy"
requires "fab"
