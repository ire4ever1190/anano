import nanoid
import src/anano
import benchy

const n = 10_000

timeIt "anano":
  for i in 0 ..< n:
    # Convert to string to be more fair
    keep $genNanoID()

timeIt "nim-neoid":
  for i in 0 ..< n:
    keep generate()
