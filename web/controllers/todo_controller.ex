defmodule Todos.TodoController do
  use Todos.Web, :controller

  alias Todos.Todo

  plug :scrub_params, "todo" when action in [:create, :update]
  plug Todos.Authentication

  def index(conn, _params) do
    user_id = conn.assigns.current_user.id
    query = from t in Todo, where: t.owner_id == ^user_id
    todos = Repo.all(query)

    render(conn, "index.json", todos: todos)
  end

  # def show(conn, %{"id" => id}) do
  #   todo = Repo.get!(Todo, id)
  #   render(conn, "show.json", todo: todo)
  # end

  def create(conn, %{"todo" => todo_params}) do
    changeset = Todo.changeset(
      %Todo{ owner_id: conn.assigns.current_user.id },
      todo_params
    )

    case Repo.insert(changeset) do
      {:ok , todo} ->
        conn
        |> put_status(:created)
        |> render("show.json", todo: todo)
      _ ->
        conn
        |> send_resp(401, "Didn't work :(")
    end
  end

  # def delete(conn, %{"id" => id}) do
  #   Repo.get!(Todo, id)
  #   |> Repo.delete!

  #   conn
  #   |> send_resp(204, [])
  # end
end
