# CourseHub

## Getting started

- Clone this project `git clone git@github.com:aramsm/CourseHub.git`
- Install Elixir 1.10.1 (recommended to use a package manager like (asdf)[https://github.com/asdf-vm/asdf-elixir])
- Install Erlang 21.1 (recommended to use a package manager like (asdf)[https://github.com/asdf-vm/asdf-erlang])
- Install dependencies with `mix deps.get`
- Create and migrate your database with `mix ecto.setup`
- Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Description

This project makes a CRUD for univeristies and its campi and courses. The courses also have price offers. Each of those entities are represented by the
following tables:

```
  universities
  name: :string
  score: :float
  logo_url: :float
```

```
  campi
  name: :string
  city: :string
  university_id: :binary_id
```

```
  courses
  name: :string
  kind: :string
  level: :string
  shift: :string
  campus_id: :binary_id
  university_id: :binary_id
```

```
  offers
  full_price: :float
  price_with_discount: :float
  discount_percentage: :float
  start_date: :string
  enrollment_semester: :string
  enabled: :boolean
  course_id: :binary_id
```

```
  accounts
  name: :string
  email: :string
  password_hash: :string
```

## Features

All create, update and delete actions can only be done in console (use the command `mix -S iex` in your terminal).
You can use the contexts modules to do those actions. For example:

```shell
  > CourseHub.Universities.create_course(params)
  {:ok, %CourseHub.Universities.Course{}}
```

You can run all tests running the command `mix test test/` in your terminal.

You can run `mix ecto.setup` or `mix ecto.reset` (for a clean start) to populate the DB with seeds.

You can list and filter `offers` and `courses` throw the entrypoints bellow. You can also order `offers` by its `price_with_discount` field in ascending or descending orientations.

### Entrypoints

> Please, sign in first to get your token and place it at the request header to be allowed in your requests.

All params are json, witch mean you have to write like this example: `{"city": "City Name"}`. However, to make ordering work, you must input as one of the two options in the table bellow.

```
================================================================================================================================
| uri            | filters                                   | order                                                           |
================================================================================================================================
| api/v1/courses | kind, shift, level, university_name, city |                                                                 |
================================================================================================================================
| api/v1/offers  | university_name, course_name, city,       | {"asc": "price_with_discount"}, {"desc": "price_with_discount"} |
================================================================================================================================
| api/v1/sign_in | email, password                           |                                                                 |
================================================================================================================================
```

## Learn more

- Official website: https://www.phoenixframework.org/
- Guides: https://hexdocs.pm/phoenix/overview.html
- Docs: https://hexdocs.pm/phoenix
- Forum: https://elixirforum.com/c/phoenix-forum
- Source: https://github.com/phoenixframework/phoenix
