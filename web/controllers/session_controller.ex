defmodule Todos.SessionController do
    use Todos.Web, :controller

    import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]

    alias Todos.User
    alias Todos.Session

    def create(conn, %{"user" => user_params}) do
        user = Repo.get_by(User, email: user_params["email"])

        cond do
            user && checkpw(user_params["unencrypted_password"], user.password) ->
                session_changeset = Session.create_changeset(%Session{}, %{user_id: user.id})
                {:ok, session} = Repo.insert(session_changeset)
                conn
                |> put_status(:created)
                |> render("show.json", session: session)
            user ->
                conn
                |> put_status(:unauthorized)
                |> render("error.json", user_params)
            true ->
                dummy_checkpw
                conn
                |> put_status(:unauthorized)
                |> render("error.json", user_params)
        end
    end
end
