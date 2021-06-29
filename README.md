# README

## Description

This is a toy app built to search books recomendations

* Ruby (2.7.1)
* Ruby on Rails 6.1.0
* Postgres 9.6
* NodeJs v12
## Setup

This project was setup with docker.

### Start the app

``` docker-compose up -d ```

### Database Setup

``` 
docker-compose exec website rails db:create 
docker-compose exec website rails db:migrate 
```

### Populate the database

```
 docker-compose exec website rails dev:populate
```

Note: At the end of the execution of this command the console will show a dummy admin user

### Run tests

```
 docker-compose exec website bundle exec rspec
```


