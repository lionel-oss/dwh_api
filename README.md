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

![Alt Text](/public/docs/img/curl_json.gif)

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

## Replaceable Fields: Hints for use

The input must be preceded  by the percentage symbol and surrounded by curly brackets as such `%{field_name}` where field_name will be the call for the field.

Therefore the simplest query would be `SELECT %{field_name};` and the curl would thus be `http://localhost:3000/api/your_endpoint?token=your_token&field_name=your_input`

If your input is a string, you must surround it with single quotes as such: `http://localhost:3000/api/your_endpoint?token=your_token&field_name='your_input'`

You have the option of making your replaceable fields a requirement or not, by using the tick on “Replaced fields required”. This will make all your replaced fields required, or all of them off. If the field is thus not defined in the curl, it will return null. It is thus recommended that you use logic in your query to make use of this case. Example below:

```
select id,
  login, 
  email
from users
where login = COALESCE (%{user_name}, login); 
```

Here we have set it up so that when no input is chosen, it will return all values in the database, and when a specific user name (aka login) is chosen, only their information will be returned. The curl for both cases would thus look like this:

For all:
```
http://localhost:3000/api/your_endpoint?token=your_token
```

For only “user”:
```
http://localhost:3000/api/your_endpoint?token=your_token&user_name='user'
```

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
