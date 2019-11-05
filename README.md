# DWH API
Add Description

# Table of contents

- [Installation](#installation)
- [Populate database](#populate-database)
- [Usage](#usage)
- [Rails Admin](#rails-admin)
- [User Creation](#user-creation)
- [User Interface](#user-interface)

## Installation
### Ruby, Rails and dependencies

Install [rvm](https://rvm.io/).

Install ruby:

- ```rvm install ruby-2.6.3```

Instal dependencies:

- ```bundle install```

### Database

Application is using Postgres database.

Create database:

- ```rake db:create```

Run all migrations:

- ```rake db:migrate```

Database config file:

- ```config/database.yml```

![Alt Text](/public/docs/img/create_migrate.gif)

## Populate database

- Rails console:

```
rails c
```

- Example data:

```
db_credential = DatabaseCredential.create(user: 'user', password: 'password', database: 'postgres', host: 'localhost', port: '5432')
access_level = AccessLevel.create(description: 'Test level')
access_level.tokens.create(name: 'my_token')
access_level.endpoints.create(query: 'select * from people;', database_credential: db_credential, name: 'test_endpoint')
```

![Alt Text](/public/docs/img/data_population.gif)

## Usage

Start server:

- ```rails s```

URL for the app:

- ```http://localhost:3000```

Api call for json:

```
curl 'localhost:3000/api/endpoint_name?token=your_token' | json_pp
```

for csv:

```
curl 'localhost:3000/api/endpoint_name.csv?token=your_token' | column -t -s, | less -S
```


Api call with replaced fields:

- SQL:
```
SELECT %{first_field} FROM USERS WHERE %{second_field};
```

- Curl example:
```
curl -X GET \
  'http://localhost:3000/api/qwerty?token=your_token&first_field=email&second_field=name%20is%20not%20null' | json_pp
```

- Postman example:
```
http://localhost:3000/api/qwerty?token=your_token&first_field=email&second_field=name is not null
```


![Alt Text](/public/docs/img/curl_json.gif)

Swagger documentation for available endpoints by token:

```
http://localhost:3000/swagger_docs?token=your_token
```

## Rails Admin

Application is using Rails Admin as simple soultion for CRUD actions.
By default, Rails Admin is accessible by `/admin` URL.

## User Creation

```
User.create(login: 'login', email: 'email@example.com', password: 'password')
```

## User Interface
- **Login Page**: Overview of Login Page.

  ![](/public/docs/img/login.png)

- **DWH APIs**: Overview of Main Admin Page.

  ![](/public/docs/img/main.png)

- **Access Levels**: Overview of Access Levels Page.

  ![](/public/docs/img/access-levels.png)

- **Database Credentials**: Overview of all Database Crenedtials with CRUD possibility.

  ![](/public/docs/img/database-credentials.png)

- **Endpoints**: Overview of all Endopoints with CRUD possibility.

  ![](/public/docs/img/list-of-endpoints.png)

- **Edit Endpoint**: Edit Endpoint

  ![](/public/docs/img/edit-of-endpoint.png)

- **RequestLogs**: Overview of all RequestLogs with CRUD possibility.

  ![](/public/docs/img/list-of-request-logs.png)

- **Tokens**: Overview of all Tokens with CRUD possibility.

  ![](/public/docs/img/list-of-tokens.png)

- **Users**: Overview of all Users with CRUD possibility.

  ![](/public/docs/img/list-of-users.png)

- **API docs**: Overview of all endpoints which accessible by token.

  ![](/public/docs/img/swagger-docs.png)
