import std/random
import std/json

import nimcorpora

randomize()

let 
  corpora = newCorpora()
  cats = corpora.getFile("animals", "cats")["cats"].getElems()

echo "Your cat of the day is ", sample(cats)