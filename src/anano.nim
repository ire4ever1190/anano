## Implementation based on https://github.com/icyphox/nanoid.nim/blob/master/src/nanoid.nim
import std/[
  math,
  sysrand,
  lenientops
]


const 
  alphabet {.strdefine.} = "_-0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
  nanoIDSize* {.intdefine.} = 21
    ## The size to use for nano IDs

  # Precompute some values
  mask = block:
    var maskVal: byte
    for i in [15.byte, 31, 63, 127, 255]:
      if i >= alphabet.len:
        maskVal = i
        break
    doAssert maskVal != 0
    maskVal
    
  step = int(ceil(1.6 * mask * nanoIDSize / alphabet.len))

type
  NanoID* = array[nanoIDSize, byte]

func `$`*(id: NanoID): string =
  ## Converts ID into a string
  result = newString(nanoIDSize)
  for i in 0..<nanoIDSize:
    result[i] = char(id[i])
    

proc genNanoID*(): NanoID =
  ## Generates a random ID.
  ## Uses `std/sysrand <https://nim-lang.org/docs/sysrand.html>`_ for RNG
  var i = 0
  block topLevel:
    while true:
      let randomBytes = urandom(step)
      for j in 0 .. step - 1:
        var randByte = randomBytes[j] and mask
        if randByte < alphabet.len:
          result[i] = byte(alphabet[randByte])
          inc i
          if i == nanoIDSize: 
            break topLevel
