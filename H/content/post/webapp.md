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

