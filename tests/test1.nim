import anano
import std/[
  unittest,
  sets
]

test "No collision for 1M entries":
  var generated: HashSet[NanoID]
  const n = 1_000_000
  for i in 0..<n:
    generated.incl genNanoID()
  check generated.len == n

test "To/from string":
  var id = genNanoID()
  check parseNanoID($id) == id
