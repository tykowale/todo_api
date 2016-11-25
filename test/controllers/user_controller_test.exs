defmodule Todos.UserControllerTest do
    use Todos.ConnCase
    alias Todos.User
    alias Todos.UserView

    @valid_attrs %{email: "ty@foo.com", unencrypted_password: "foobar"}

    test "#index returns all users" do
        conn = build_conn()
        user = insert(:user)

        conn = get(conn, user_path(conn, :index))

        assert json_response(conn, 200) == render_json(UserView, "index.json", users: [user])
    end

    test "#show renders a single user when found" do
        conn = build_conn()
        user = insert(:user)

        conn = get(conn, user_path(conn, :show, user))

        assert json_response(conn, 200) == render_json(UserView, "show.json", user: user)
    end

    test "#show displays an error when user not found" do
        conn = build_conn()
        user = %{insert(:user) | id: -1}

        conn = get(conn, user_path(conn, :show, user))

        assert response(conn, 404) != ""
    end

    test "#create renders when resource is valid" do
        conn = build_conn()

        conn = post(conn, user_path(conn, :create), %{user: @valid_attrs})
        response_body = response_body_to_map(conn.resp_body, "user")

        assert json_response(conn, 200) == render_json(UserView, "show.json", user: response_body)

        users = Repo.all(User)
        assert(length(users) == 1)
    end

    test "#create when there is an error creating" do
        conn = build_conn()
        user = %{@valid_attrs | email: ""}

        conn = post(conn, user_path(conn, :create), %{user: user})
        assert response(conn, 401) == "There was an error creating your user"

        users = Repo.all(User)
        assert(length(users) == 0)
    end

    test "#delete removes entry by id" do
        conn = build_conn()
        user = insert(:user)

        users = Repo.all(User)
        assert(length(users) == 1)

        conn = delete(conn, user_path(conn, :delete, user))
        assert response(conn, 204) == ""

        users = Repo.all(User)
        assert(length(users) == 0)
    end
end
