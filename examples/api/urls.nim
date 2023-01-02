import prologue

import ./views


let urlPatterns* = @[
  pattern("/get/{path}$", path),
  pattern("/index", index),
  pattern("/files", files),
  pattern("/directories", directories),
  pattern("/dirs", directories)
]
