defmodule Todos.UserController do
    use Todos.Web, :controller
    alias Todos.User

    def index(conn, _params) do
        users = Repo.all(User)

        render(conn, "index.json", users: users)
    end

    def show(conn, %{"id" => id}) do
        try do
            user = Repo.get!(User, id)

            render(conn, "show.json", user: user)
        rescue
            e in Ecto.NoResultsError ->
                conn
                |> send_resp(404, e.message)
        end
    end

    def create(conn, %{"user" => user_params}) do
        changeset = User.registration_changeset(%User{}, user_params)

        case Repo.insert(changeset) do
            {:ok, user} ->
                conn
                |> render("show.json", user: user)
            _ ->
                conn
                |> send_resp(401, "There was an error creating your user")
        end
    end

    def delete(conn, %{"id" => id}) do
        Repo.get!(User, id)
        |> Repo.delete!

        conn
        |> send_resp(204, "")
    end
end
