### Anano
Another nanoID implementation for Nim.

This implementation is based off of [nim-neoid](https://github.com/theAkito/nim-neoid) but uses 
more compile time computations to give massive speedups. Anano also only uses the standard library
to reduce the number of dependencies needed.

Works on `c`, `c++` and `js` backends

Main reason I built this was so I could learn how the ID was generated but also make it generate
an `array[byte]` instead so I could better store it in a database for another project of mine

> **Warning**
> I am not a security expert and this has not be vetted. Use this at your own risk

#### Usage

```nim
import anano

let id = genNanoID()
echo id
```

#### Benchmarks
(From `benchmark.nim`, compiled with `-d:release`)

```
name ............................... min time      avg time    std dv   runs
anano ............................. 13.078 ms     13.182 ms    ±0.205   x376
nim-neoid ........................ 174.737 ms    181.768 ms    ±7.628    x28
```

