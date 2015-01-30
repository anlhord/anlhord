+++
date = "2015-01-21T20:56:26+01:00"
draft = true
title = "Creating a google app engine + cloud sql app"

+++

Since google cloud sql is like a mysql,
[https://cloud.google.com/appengine/docs/go/cloud-sql/](I'm going to try it.)

at the bottom there is cloud sql. We go get github.com/go-sql-driver/mysql
```
	"database/sql"
	_ "github.com/go-sql-driver/mysql"
```
set the command line project:
```
gcloud config set project fooo-bar-575
```
[https://cloud.google.com/sql/docs/admin-api/](All info is in the cloud sql management doc.)
list the cloud sql instances:
```
gcloud sql instances list
```

[https://cloud.google.com/sql/docs/mysql-client?csw=1](Apparently, whitelisting an ip and setting a root password is needed to connect.) We assign an ip to the instance:

```
gcloud sql instances patch YOUR_INSTANCE_NAME --assign-ip
```

This is the way to change the root password on the database:

```
gcloud sql instances set-root-password XXXXXXXXXXX --password YYYYYYYYYYYY
```
Now, to connect to the db via the mysql client, do this:

```
mysql --host=x.x.x.x  --port=3306 --user=root --password
```

Now feel free to make the databases you need.

Ok what about connecting from localhost goapp serve to google cloud sql. Simple.
Set a root password either from the gui or cli. In gui click the instance
and click an access control tab. from there u can set a root password.
Also give access  [http://myip.dk](to your ip). Also create a database.
Now use the library:
```
	_ "github.com/go-sql-driver/mysql"
```

Use a login string like this:
```
		c = "root:PASSWROD@tcp(IP:PORT)/DATABASE"
```
Now. On the gae, use a different login string.

```
root:@cloudsql(PROJECTID:DBID)/db
```


