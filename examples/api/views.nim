import std/sequtils
import std/strutils
import std/json

import prologue
import nimcorpora


template setHeaders* = ctx.response.addHeader("Content-Type", "application/json")

proc get*(ctx: Context) {.async.} =
  let corpora = new Corpora

  setHeaders()

  # default 500 error handler doesnt work for some reason so we do this

  try:
    resp $corpora.getFile(ctx.getPathParams("path"))
  except:
    resp $(%*{"errorCode": 500, "errorMsg": getCurrentExceptionMsg()}), Http500

proc index*(ctx: Context) {.async.} =
  let corpora = new Corpora
  var indexJson = newJObject()

  setHeaders()

  for category in corpora.categories:
    var subcategories = corpora.getSubcategories(category)
    subcategories.applyIt(it.replace("\\", "/"))

    indexJson[category] = %subcategories

  resp $indexJson

proc files*(ctx: Context) {.async.} =
  let corpora = new Corpora

  var subcategories = corpora.subcategories
  subcategories.applyIt(it.replace("\\", "/"))

  setHeaders()

  resp $(%subcategories)

proc directories*(ctx: Context) {.async.} = 
  let corpora = new Corpora

  var categories = corpora.categories
  categories.applyIt(it.replace("\\", "/"))

  setHeaders()

  resp $(%categories)

proc err500*(ctx: Context) {.async.} = 
  setHeaders()
  resp $(%*{"errorCode": 500, "errorMsg": getCurrentExceptionMsg()}), Http500

proc err404*(ctx: Context) {.async.} = 
  setHeaders()
  resp $(%*{"errorCode": 404, "errorMsg": "The system could not find the path specified."}), Http404
