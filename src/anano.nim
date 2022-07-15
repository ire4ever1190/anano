# Implementation based on https://github.com/icyphox/nanoid.nim/blob/master/src/nanoid.nim

##[
  NanoID is unique ID generator that are URL friendly and have a small chance of collision.
  
  The alphabet used and size of the ID can be controlled with `-d:nanoIDSize=<yourSize>` and `-d:nanoAlphabet=<yourAlphabet>` respectively
]##

runnableExamples:
  let id = genNanoID()
  echo id # Will be some string like opPOmFDJz4m1k01OTUks_

import std/[
  math,
  sysrand,
  lenientops
]


const 
  nanoAlphabet* {.strdefine.} = "_-0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    ## Alphabet used for the IDs
  nanoIDSize* {.intdefine.} = 21
    ## The size to use for nano IDs

  # Precompute some values
  mask = byte(nextPowerOfTwo(nanoAlphabet.len)) - 1
    
  step = int(ceil(1.6 * mask * nanoIDSize / nanoAlphabet.len))

type
  # Basically a fixed sized string
  NanoID* = array[nanoIDSize, char]

func `$`*(id: NanoID): string =
  ## Converts ID into a string
  result = newString(nanoIDSize)
  for i in 0..<nanoIDSize:
    result[i] = id[i]
    
proc parseNanoID*(id: openArray[char]): NanoID =
  ## Parses a nanoID from a string like parameter
  runnableExamples:
    let id = genNanoID()
    # ID has been sent to client, then client is sending it
    # back but in string form
    let strID = $id
    assert parseNanoID(strID) == id
    
  runnableExamples "-d:nanoIDSize=4":
    assert parseNanoID(['a', 'b', 'c', 'd']) == parseNanoID("abcd")
  #==#
  assert id.len == nanoIDSize, "ID is of invalid size"
  for i in 0..<nanoIDSize:
    result[i] = id[i]

proc genNanoID*(): NanoID =
  ## Generates a random ID.
  ## Uses `std/sysrand <https://nim-lang.org/docs/sysrand.html>`_ for RNG
  var i = 0
  block topLevel:
    while true:
      let randomBytes = urandom(step)
      for j in 0 .. step - 1:
        var randByte = randomBytes[j] and mask
        if randByte < nanoAlphabet.len:
          result[i] = nanoAlphabet[randByte]
          inc i
          if i == nanoIDSize: 
            break topLevel
