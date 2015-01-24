+++
date = "2015-01-21T20:56:26+01:00"
draft = true
title = "Creating a google app engine aerospike application"

+++



So I've registered for a google app engine trial.

I found this database called aerospike. Decided to give it a go.

Now I've decided to push some basic pages and redirect the dns.

I've created a git repository.

Installed the google cloud sdk by using:
```
curl https://sdk.cloud.google.com | bash
```

Authenticate to Google Cloud Platform by running gcloud auth login.

cloned the git repo



```
package hello

import (
    "fmt"
    "net/http"
)

func init() {
    http.HandleFunc("/", handler)
}

func handler(w http.ResponseWriter, r *http.Request) {
    fmt.Fprint(w, "Hello, world!")
}
```

created the basic app.yaml

```
application: *xxxxx*
version: 1
runtime: go
api_version: go1

handlers:
- url: /.*
  script: _go_app
```

put the app to the default/ folder.

also downloaded the appengine sdk.

```
goapp serve
```
worked. Then ran
```
goapp deploy -oauth
```

setting up dns
===

compute -> go app engine -> settings

after creating the TXT record the google picked it up.

adding a qa CNAME and picked up instantly.

Fun with aerospike.
===

[this blog post has the setup guide](http://lynnlangit.com/2014/06/24/how-to-installing-aerospikedb-on-google-compute-engine/)

Our main goal is to funnel the queries from the front page to the aerospike
database. The struct will be ID, question, price, asker, sol id, sol bool

The aerospike deployed by click to deploy. It also provides the tunnel option
to the amc (aerospike management console). Then connect via http://localhost:8081/

Created a namespace called qa

```
appcfg.py --oauth2 rollback .
```

On app engine this call fails:

```
	c, e = aerodb.NewCluster(aerodb.NewClientPolicy(), h...)
```

there's a language called aql. but we will use the cli directly.

```
cli -n qa -s q -o set -k "best blog" -b pay -v 10
cli -n qa -s q -o set -k "best blog" -b asker -v 0
cli -n qa -s a -o set -k  -b asker -v "http://go.lad.nu/"
```


This was my aerospike configuration

```
namespace foooo {
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

I've killed the aerospike cluster, so the above snipped is in case i need it later.

