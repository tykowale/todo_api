defmodule Todos.SessionControllerTest do
    use Todos.ConnCase

    alias Todos.Session
    alias Todos.User

    @valid_attrs %{email: "ty@foo.com", unencrypted_password: "foobar"}

    test "creates and renders resource when data is valid" do
        conn = build_conn()

        User.registration_changeset(%User{}, @valid_attrs)
        |> Repo.insert

        conn = post(conn, session_path(conn, :create), %{user: @valid_attrs})
        token = json_response(conn, 201)["data"]["token"]

        assert Repo.get_by(Session, token: token)
    end

    test "#create returns 401 on invalid password" do
        conn = build_conn()
        User.registration_changeset(%User{}, @valid_attrs)
        |> Repo.insert

        conn = post(conn, session_path(conn, :create), user: %{@valid_attrs| unencrypted_password: "notright"})
        assert json_response(conn, 401)["errors"] != :empty
    end

    test "#create returns 401 on invalid email" do
        conn = build_conn()
        User.registration_changeset(%User{}, @valid_attrs)
        |> Repo.insert

        conn = post(conn, session_path(conn, :create), user: %{@valid_attrs| email: "foo@bar.com"})
        assert json_response(conn, 401)["errors"] != :empty
    end
end
