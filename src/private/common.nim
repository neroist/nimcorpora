import std/os

func tailTailDir*(dir: string): string {.inline.} = dir.tailDir.tailDir

template withDir*(dir: string, body: untyped): untyped =
  let cwd = getCurrentDir()
  if not dirExists(dir): createDir(dir)

  setCurrentDir dir

  body

  setCurrentDir cwd
