from os import tailDir

func tailTailDir*(dir: string): string {.inline.} = 
  dir.tailDir.tailDir
