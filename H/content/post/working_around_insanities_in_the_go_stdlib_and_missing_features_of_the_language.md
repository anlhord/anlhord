+++
date = "2015-01-18T20:56:26+01:00"
draft = true
title = "Workaround insanities in go stdlib and go 2.0 wishlist"

+++

[less? really?](https://github.com/golang/go/blob/master/src/sort/sort.go)
--------------

```
// Package sort provides primitives for sorting slices and user-defined
// collections.
package sort
// A type, typically a collection, that satisfies sort.Interface can be
// sorted by the routines in this package. The methods require that the
// elements of the collection be enumerated by an integer index.
type Interface interface {
// Len is the number of elements in the collection.
Len() int
// Less reports whether the element with
// index i should sort before the element with index j.
Less(i, j int) bool
// Swap swaps the elements with indexes i and j.
Swap(i, j int)
}
```


since almost forever, **comparisons are done by substracting the elements**. then
you compare the int with zero. this is the case in the
[c standard library](http://www.cplusplus.com/reference/cstdlib/qsort/)
and pretty much everywhere else.

The choice of less is really unfortunate and leads to [a really stupid double less to check for equality pattern](https://github.com/golang/go/blob/master/src/sort/sort.go#L137).
```
	for b < c {
if data.Less(pivot, c-1) { // data[c-1] > pivot
c--
} else if !data.Less(c-1, pivot) { // data[c-1] = pivot
data.Swap(c-1, d-1)
c--
d--
} else {
break
}
```

The boolean itself is **a sign that you're doing something wrong**, in fact
using byte or int stead of a boolean everywhere is the best thing you can do.
Internally a boolean is a byte anyway.



misuse of duck typing for everything.
--------------

When you see an interface with methods like len, at, swap. Take a guess what
type would implement this.


99% of things implementing this interface are going to be slices. So we when
some procedure takes this interface its in fact meant to be used for slices.

Sadly go has no built in support for a safe void* pointer.

slow sorting in stdlib
--------------

[people have noticed](http://stackoverflow.com/questions/23276417/golang-custom-sort-is-faster-than-native-sort)
that an interface dispatch is not the best thing to do in a tight loop. so we would like to have a buillt-in mechanism for this. the mechanism to do this corectly is actually possible and nice, but it needs a change in the go language. so it the current way of doing  doing this in the stdlib is not terribly bad. the bolierplate of len, swap, at methods is actually the bad thing about it.



so we break the type system
--------------

The best way currently to break the go type system [is as follows](https://github.com/gomacro/sort/blob/master/unsafe/quick/quick.go#L21):
```
func mvetype(dst, src *interface{}) {
*(*uintptr)(unsafe.Pointer(dst)) = *(*uintptr)(unsafe.Pointer(src))
}
```
This function moves the type pointer from the intended type to the variable a type needs to be changed.
The eface object (interface{}) is as follows:
```
struct Eface
   195	{
   196		Type*	type;
   197		void*	data;
   198	};

```

We swapped the Type pointer from the slice of the wanted type ([]uint8) to a slice of arbitrary type []foo.
We cast the eface to unsafe pointer, then we copy the pointer to another eface.
this is best used to turn object dst to type of object src.
it is nice to use this to turn a function getting pointers of any type to accepting pointers of any other type.

in the maccro library project, we've implemented the maccro library approach. we 're using this eface trick to interface with existing go code until (if ever) go language expressiveness improves.

reflection 
--------------

the only good things about reflection is the low performance and ugly syntax, to discourage people from using it unless absolutely necessarey and leads to a better code quality overall.
in maccro library project we use it minimally and mainly the slice heasder struct.

can we do better?
--------------
we can't do worse! the go macro library is the result. It has [sane compare functions
for go builtin types](https://github.com/gomacro/compare), [the sorting](https://github.com/gomacro/sort) is actually fast, etc.



go 2.0 wish list.
--------------

 * safe void pointer andvoid slice.

 * strided slice.
  * the need for strided slice comes up here and there. the currently standard
    way to impplement it is to pass stride int along with a slice.
