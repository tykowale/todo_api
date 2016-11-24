defmodule Todos.UserControllerTest do
    use Todos.ConnCase
    alias Todos.User
    alias Todos.UserView

    @valid_attrs %{email: "ty@foo.com", unencrypted_password: "foobar"}

    test "#create renders when resource is valid" do
        conn = build_conn()
        user = @valid_attrs

        conn = post(conn, user_path(conn, :create, user), %{user: user})
        response_body = response_body_to_map(conn.resp_body, "user")

        assert json_response(conn, 200) == render_json(UserView, "show.json", user: response_body)

        users = Repo.all(User)
        assert(length(users) == 1)
    end
end
