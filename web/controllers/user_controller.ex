defmodule Todos.UserController do
    use Todos.Web, :controller
    alias Todos.User

    def create(conn, %{"user" => user_params}) do
        changeset = User.changeset(%User{}, user_params)

        case Repo.insert(changeset) do
            {:ok, user} ->
                conn
                |> render("show.json", user: user)
            {:error, changeset} ->
                conn
                |> send_resp(400, [])
        end
    end
end
