# Package

version       = "0.1.0"
author        = "Jasmine"
description   = "A Nim interface for Darius Kazemi's Corpora Project."
license       = "GPL-3.0-only"
srcDir        = "src"
skipDirs      = @["examples"]


# Tasks

after install:
  echo "Installing Corpora data..."
  selfExec"r ./nimcorpora/install.nim"

# Dependencies

requires "nim >= 1.6.10"
requires "zippy"
requires "fab"
