# Ported from Python concurrent prime sieve

from std/os import paramCount, paramStr
from std/strutils import parseInt


# Alias for closure iterator type for readablility
type coroutine = (iterator(): int {.closure.})


iterator generate(): int {.closure.} =
  var i = 2
  while true:
    yield i
    i += 1


func initFilter(ch: coroutine, prime: int): coroutine =
  return iterator(): int {.closure.} =
    for i in ch():
      if (i mod prime) != 0:
        yield i


proc findPrimes(n: int): void =
  var ch: coroutine = generate
  for i in 0 ..< n:
    let prime = ch()
    echo prime
    ch = initFilter(ch, prime)


when isMainModule:
  let n = if paramCount() > 0: parseInt(paramStr(1)) else: 100
  findPrimes(n)


