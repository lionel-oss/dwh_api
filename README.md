# DWH API
## Installation
### Ruby, Rails and dependencies

Install [rvm](https://rvm.io/).

Install ruby:

```rvm install ruby-2.6.3```

Instal dependencies:

```bundle install```

### Database

Application is using Postgres database.

Create database:

```rake db:create```

Run all migrations:

```rake db:migrate```

## Populate database

Example data:

```
dc = DatabaseCredentials.create(user: 'user', password: 'password', database: 'postgres', host: 'localhost', port: '5432')
token = Token.create(name: 'my_token')
Endpoint.create(query: 'select * from people;', token: token, database_credential: dc, name: 'test_endpoint')
```

## Usage

Start server:

```rails s```
