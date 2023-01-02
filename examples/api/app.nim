import std/with
import std/os

from prologue/middlewares/staticfile import redirectTo
import prologue/openapi
import nimcorpora
import prologue

import ./views
import ./urls


# automatically install Corpora data
if not dirExists("../data"):
  installCorporaData("..", output = off)

let
  env = loadPrologueEnv(".env")
  settings = newSettings(appName = env.getOrDefault("appName", "Prologue"),
                         debug = env.getOrDefault("debug", true),
                         port = Port(env.getOrDefault("port", 8080)),
                         secretKey = env.getOrDefault("secretKey", "")
    )
  
# Be careful with the routes.
var app = newApp(settings = settings)

with app:
  registerErrorHandler(Http500, err500)
  registerErrorHandler(Http404, err404)
  serveDocs("docs/openapi.json")
  addRoute(urls.urlPatterns, "")
  get("/favicon.ico", redirectTo("/static/favicon.ico"))
  run()
