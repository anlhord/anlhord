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



On google app engine onecan deploy in a very simple

```
goapp deploy -oauth
appcfg.py --oauth2 rollback .
```
