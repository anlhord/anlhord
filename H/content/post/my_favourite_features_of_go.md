+++
date = "2015-01-17T20:56:26+01:00"
draft = true
title = "My favorite features of go"

+++


My favorite features of go:



 * design of the language 
 * built-in maps
 * the go keyword. 
 *  closures. 
 * the receiver.
 *  use of return valuses instead of pointer arguments
 *  the error type
 * panic
 *  the tests and benchmarks
 *  profiling.
 * coverage testing.
 * sane integer covertions and sizes, overflows
 * slices
 * good standard library
 * attempting to be a safe language
 * absence of junk 
  * ( exceptoons, weird syntax, weird symbols)

Things to get used to

 * coding style
 * capital 

Go annoyances

 * missing package
 * unused variable
  * ( solution is simple, fix the compiler, fix code on commit.)
 * the casts
  * are annoying but for a good reason-makes people think twice before using anything else than an int.
 * annoying type system
  * solution: break it. currently best way is the eface trick.

