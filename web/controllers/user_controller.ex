defmodule Todos.UserController do
    use Todos.Web, :controller
    alias Todos.User

    def create(conn, %{"user" => user_params}) do
        changeset = User.registration_changeset(%User{}, user_params)

        case Repo.insert(changeset) do
            {:ok, user} ->
                conn
                |> render("show.json", user: user)
            {:error, _} ->
                conn
                |> send_resp(401, "There was an error creating your user")
        end
    end
end
