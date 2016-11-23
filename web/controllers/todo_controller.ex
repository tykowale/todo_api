defmodule Todos.TodoController do
    use Todos.Web, :controller

    alias Todos.Todo

    def index(conn, _params) do
        todos = Repo.all(Todo)
        render(conn, "index.json", todos: todos)
    end

    def show(conn, %{"id" => id}) do
        todo = Repo.get!(Todo, id)
        render(conn, "show.json", todo: todo)
    end

    def create(conn, %{"todo" => todo_params}) do
        changeset = Todo.changeset(%Todo{}, todo_params)

        case Repo.insert(changeset) do
            {:ok , todo} ->
                conn
                |> render("show.json", todo: todo)
            {:error, changeset} ->
                render(conn, "show.html", changeset: changeset)
        end
    end

    def delete(conn, %{"id" => id}) do
        IO.puts "DELETE HIT!!!!!!"
        todos = Repo.all(Todo)
        render(conn, "index.json", todos: todos)
    end
end
