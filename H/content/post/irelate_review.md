+++
date = "2015-01-22T20:56:26+01:00"
draft = true
title = "Short review of irelate"

+++

reviewing article
the author of the article brentp has used go for bioinformatics. Used vim-go, closure as iterators etc. The project can
be found at https://github.com/brentp/irelate



The first thing that interested me is how separate (sorted) data-sources are merged into a single stream.

The merge is in /irelate.go

It first loads an interval from each stream. It sets an id of source (the # of stream).
Then it pushes these objects to the heap.
Then it makes the channel of relatable with capacity of 8.

It then pops iterval,  pushes new interval to the tiny heap from the same channel and sends the intervals together
with the source down the output channel.

This works because the intervals on each channel are already sorted.


