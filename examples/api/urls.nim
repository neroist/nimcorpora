import prologue/openapi
import prologue

import ./views


let urlPatterns* = @[
  pattern("/get/{path}$", get),
  pattern("/index", index),
  pattern("/files", files),
  pattern("/directories", directories),
  pattern("/dirs", directories),
  pattern("/", swaggerHandler) 
]
