import std/os


# we use this template to make nimcorpora GC safe
template setDataVar*: untyped =
  let data = (when defined(release): getCurrentDir() else: currentSourcePath().parentDir).parentDir / "data"

template withDir*(dir: string, body: untyped): untyped =
  let cwd = getCurrentDir()
  if not dirExists(dir): createDir(dir)

  setCurrentDir dir

  body

  setCurrentDir cwd
