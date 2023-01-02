import std/os

import prologue/openapi
import nimcorpora
import prologue

import ./urls

# automatically install Corpora data
if not dirExists("../data"):
  installCorporaData("..", output = off)

let
  env = loadPrologueEnv(".env")
  settings = newSettings(appName = env.getOrDefault("appName", "Prologue"),
                         debug = env.getOrDefault("debug", true),
                         port = Port(env.getOrDefault("port", 8080)),
                         secretKey = env.getOrDefault("secretKey", "Pr435ol67ogue")
    )


var app = newApp(settings = settings)
# Be careful with the routes.
app.addRoute(urls.urlPatterns, "")
app.serveDocs("docs/openapi.json")
app.run()
