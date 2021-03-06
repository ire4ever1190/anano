# Package

version       = "0.2.1"
author        = "Jake Leahy"
description   = "Another nanoID implementation for nim"
license       = "MIT"
srcDir        = "src"


# Dependencies

requires "nim >= 1.6.0"

task benchmark, "Run benchmark":
  exec "nim r -d:release benchmark.nim"
