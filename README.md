# Todos

To start the Phoenix app:

    * Install dependencies with `mix deps.get`
    * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
    * Install Node.js dependencies with `npm install`
    * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

# Road Map

Create todo:

    * ~~Migration for todos~~
    * ~~Views for controller (all and individual)~~
    * ~~CRUD controller~~

Create user:

  * Migration for user
  * Views for controller (all and individual)
  * CRUD controller
  * Incorporate encryption

Associate Todo with user:

    * Users own todos (one to many)
    * Update migrations
    * Change todo index route to only show current user todos
    * Create route needs user id
    * Delete only allows user to delete their todos

Front End Portion
    * The whole thing
