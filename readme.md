### Anano
Another nanoID implementation for Nim.

This implementation is based off of [nim-neoid](https://github.com/theAkito/nim-neoid) but 
- uses more compile time code to give massive speedups (This comes with the tradeoff though that you can't define options at runtime).
- Only uses the nim standard library

Works on `c`, `c++` and `js` backends

Main reason I built this was so I could learn how the ID was generated but also make it generate
an `array[byte]` instead so I could better store it in a database for another project of mine

> **Warning**
> I am not a security expert and this has not be vetted. Use this at your own risk

#### Usage
[docs](https://tempdocs.netlify.app/anano/stable/anano.html)

```nim
import anano

let id = genNanoID()
echo id
```

#### Benchmarks

Time for generating 10000 elements

```
name ............................... min time      avg time    std dv   runs
anano .............................. 9.276 ms      9.442 ms    ±0.237   x525
nim-neoid ........................ 180.788 ms    186.523 ms    ±7.320    x27
```
(From `benchmark.nim`, compiled with `-d:release`)

