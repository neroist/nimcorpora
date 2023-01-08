# Package

version       = "0.1.1"
author        = "Jasmine"
description   = "A Nim interface for Darius Kazemi's Corpora Project."
license       = "GPL-3.0-only"
srcDir        = "src"
skipDirs      = @["examples", "docs"]


# Tasks

after install:
  echo "\nInstalling Corpora data..."
  selfExec "r ./nimcorpora/install.nim"


# Dependencies

requires "nim >= 1.4.0"
requires "zippy"
requires "fab"
