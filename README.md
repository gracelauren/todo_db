Todo App
==============

by Grace Mekarski and Mike Goren

Todo is a website that uses a database and Sinatra to allow users to create tasks and add them to lists.

Installation
------------

Install Todo by first cloning the repository.  
```
$ git clone http://github.com/gracelauren/todo_db.git
```

Install all of the required gems:
```
$ bundle install
```

Start the database:
```
$ postgres
```

Create the databases and tables:
```
# psql
```

```
username=# CREATE DATABASE todo;
```

```
username=# \c todo;
```

```
todo=# CREATE TABLE tasks (id serial PRIMARY KEY, description varchar, due timestamp, list_id int);
```

```
todo=# CREATE TABLE lists (id serial PRIMARY KEY, name varchar);
```

```
todo=# CREATE DATABASE todo_test WITH TEMPLATE todo;
```

Start the webserver:
```
$ ruby app.rb
```

In your web browser, go to http://localhost:4567

License
-------

GNU GPL v2. Copyright 2015 Mike Goren and Grace Mekarski
