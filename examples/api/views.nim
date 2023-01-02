import std/strutils
import std/json

import prologue
import nimcorpora


template setHeaders = ctx.response.addHeader("Content-Type", "application/json")

proc path*(ctx: Context) {.async.} =
  let corpora = new Corpora

  setHeaders()

  try:
    resp $corpora.getFile(ctx.getPathParams("path"))
  except:
    resp $(%*{"errorCode": 500, "errorMsg": getCurrentExceptionMsg()}), Http500

proc index*(ctx: Context) {.async.} =
  let corpora = new Corpora
  var indexJson = newJObject()

  setHeaders()

  for category in corpora.categories:
    indexJson[category] = newJArray()
    indexJson[category].add %corpora.getSubcategories(category)

  resp $indexJson

proc files*(ctx: Context) {.async.} =
  let corpora = new Corpora

  setHeaders()

  resp $(%corpora.subcategories)

proc directories*(ctx: Context) {.async.} = 
  let corpora = new Corpora

  setHeaders()

  resp $(%corpora.categories)
