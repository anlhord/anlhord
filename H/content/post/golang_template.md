+++
date = "2015-01-19T20:56:26+01:00"
draft = true
title = "Creating a google app engine aerospike application"

+++

We can try redering some html/template with our app.

[Writing Web Applications.](https://golang.org/doc/articles/wiki/#tmp_6)

First, we must add html/template to the list of imports.

Setting up templating was done by this function:


This is how to serve a static content from the google app engine:

```
handlers:
- url: /assets
  static_dir: static

- url: /.*
  script: _go_app
```
We serve stuff from the directory *static* to the url http://example.com/assets/img/x.png

Fun with aerospike.

[this blog post has the setup guide](http://lynnlangit.com/2014/06/24/how-to-installing-aerospikedb-on-google-compute-engine/)

Our main goal is to funnel the queries from the front page to the aerospike
database. The struct will be ID, question, price, asker, sol id, sol bool

The aerospike deployed by click to deploy. It also provides the tunnel option
to the amc (aerospike management console). Then connect via http://localhost:8081/

Created a namespace called qa

```
namespace qa {
        replication-factor 2
        memory-size 4G

	high-water-memory-pct 60
	high-water-disk-pct 50
	stop-writes-pct 90

        default-ttl 0 # 30 days, use 0 to never expire/evict.


        ldt-enabled true

        storage-engine device {
               file /opt/aerospike/data/qa.dat
               filesize 16G
               # See http://discuss.aerospike.com/t/aerospike-doesnt-work-with-local-ssd-disks-at-gce/497/4
               disable-odirect true
               data-in-memory true # Store data in memory in addition to fil
       }
}
```

there's a language called aql. but we will use the cli directly.

```
cli -n qa -s q -o set -k "best blog" -b pay -v 10
cli -n qa -s q -o set -k "best blog" -b asker -v 0
cli -n qa -s a -o set -k  -b asker -v "http://go.lad.nu/"
```
