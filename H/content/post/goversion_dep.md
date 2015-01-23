+++
date = "2015-01-20T20:56:26+01:00"
draft = true
title = "Package requires Go 1.2"

+++

You can negate build tags by prefixing with !. For instance, to support go1.2 and up, move the specific code to a file, and add this to the top:

```
// +build go1.2

package irc
// ...
```

Then in another file, write the code that should only build with versions lower than go1.2:
```
// +build !go1.2

package irc
// ...
```
I tested this with go versions 1.4 and 1.1, albeit a very simple one :) Hope this helps!

