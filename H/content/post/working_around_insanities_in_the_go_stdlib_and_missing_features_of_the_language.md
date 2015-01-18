+++
date = "2015-01-18T20:56:26+01:00"
draft = true
title = "Workaround insanities in go stdlib and go 2.0 wishlist"

+++
Working around  insanities in the go stdlib and 

the go langis my favourite language. it is very suitable for user-space programming given the garbage collector. the design of the language is wonderful and the. my favourite things: garbage collector. built-in maps. the go keyword. data structures. closures. the receiver. . use of return valuses instead of pointer arguments. the error type. panic. the tests and benchmarks.
easy profiling.
coverage testing.
.

gofmt.

gofmt.

capital letters 
const

sane integer covertions and sizes

sane overflows

slices

good standard library

language safety
absence of junk ( exceptoons weird syntax symbols, curly braces
the annoyances - missing package xxx, unused variable xxx .. simple-fx the compiler, fix code on commit.

the casts- are annoying but for a good reason-makes people think twice before using anything else than an int.

theeface trick. the best way currently to break the  only when i have a good resason for doing so..
.

misuse of duck typing. when you see an interface  with methods like len, at, swap. take a guess what type would implement this . yes, people  or  things implementing this interface are goingtobeslices. so we  when some procedure takes this interface  its in fact meant  to be  usedfor slices.
. so . so  this is okkay but an interface dispatch is not the best thing to do in a tight loop. so we would like to have a buillt-in  mechanism for . the mechanism to do this orrectly is actually possible and nice, but it needsachange in the golanguage. so it the current way of doing  doing this in the stdlib is not terribly bad. the bolierplate of len, swap, at methods is actually the insanity.

less? really?
since almost forever, comparisons are done by substracting the elements. then you compare . this is the case in the c standard library and pretty much everywhere else.
 the choice iof less is really unfortunate and leads to areally stupid double less to check for equality patternn. the boolean itself is asinggn that you're doing something wrong, in fact using byte or int stead of a boolean everywhere is the best thing you can do. internally a boolean is a byte anyway.
.

so we break th e type system

the eface swap trick is as follows. we swapt the . we cast the eface to unsafe pointer, then we copy the pointer to another eface.
given that .
we copy the eface with needed type, then we copy the source esafe pointer to dst esafe type.
this effectively change sthe data reference  with different type.
thisis best used to turn  slices into uint slices.
it is alsonice to use this to turn a function getting pointers of any type to accepting pointers of any other type.

in the macrogenerics project, we've implemented the macrogenerics approach. we 're using th is eface trick to interface with existing go code.

reflection .

the only good things about reflection is the low performance and ugly syntax. this discourages people from using it unless absolutely necessarey and leads to a better code quality overall.
in maccro generics project we use it minimally and mainly the slice heasder struct.

.
go 2.0 wish list.

safe voidpointer andvoidslice.
strided slice.

strided slice. the need for strided slice comes up here and there. the currently standard way to impplement a 
. the currently est way to 
 the current idiom is to pass stride int along with a slice.
