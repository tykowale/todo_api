defmodule Todos.TodoControllerTest do
  use Todos.ConnCase
  alias Todos.{Todo, User, Session, Repo}

  setup %{conn: conn} do
    user = create_user(%{name: "Ty"})
    session = create_session(user)

    conn = conn
    |> put_req_header("accept", "application/json")
    |> put_req_header("authorization", ~s(Token token="#{session.token}"))
    {:ok, conn: conn, current_user: user}
  end

  defp create_user(%{name: name}) do
    User.changeset(%User{}, %{email: "#{name}@foo.com", unencrypted_password: "1234567"}) |> Repo.insert!
  end

  defp create_session(user) do
    Session.create_changeset(%Session{user_id: user.id}, %{}) |> Repo.insert!
  end

  defp create_todo(%{title: _title, owner_id: _owner_id} = options) do
    Todo.changeset(%Todo{}, options) |> Repo.insert!
  end

  test "#index renders a list of todos", %{conn: conn, current_user: current_user} do
    create_todo(%{title: "foo", owner_id: current_user.id})

    another_user = create_user(%{name: "tyler"})
    create_todo(%{title: "bar", owner_id: another_user.id})

    conn = get(conn, todo_path(conn, :index))

    assert conn.status == 200
    assert Enum.count(json_response(conn, 200)["todos"]) == 1
  end

  # test "#show renders a single todo" do
  #     conn = build_conn()
  #     todo = insert(:todo)

  #     conn = get conn, todo_path(conn, :show, todo)

  #     assert json_response(conn, 200) == render_json(TodoView, "show.json", todo: todo)
  # end

  # test "#create stores properly formatted todos" do
  #     conn = build_conn()
  #     todo = %{
  #         description: "task description",
  #         title: "Task 1"
  #     }

  #     conn = post(conn, todo_path(conn, :create, todo), %{todo: todo})

  #     response_body = response_body_to_map(conn.resp_body, "todo")

  #     assert json_response(conn, 200) == render_json(TodoView, "show.json", todo: response_body)

  #     todos = Repo.all(Todos.Todo)
  #     assert(length(todos) == 1)
  # end

  # test "#create does not store improperly formatted todos" do
  #     conn = build_conn()
  #     todo = %{
  #         description: "Task 1",
  #         thing: 2
  #     }

  #     conn = post(conn, todo_path(conn, :create, todo), %{todo: todo})
  #     assert(response(conn, 400) == "")

  #     todos = Repo.all(Todos.Todo)
  #     assert(length(todos) == 0)
  # end

  # test "#delete removes entry by id" do
  #     conn = build_conn()
  #     todo = insert(:todo)

  #     todos = Repo.all(Todos.Todo)
  #     assert(length(todos) == 1)

  #     conn = delete(conn, todo_path(conn, :delete, todo))
  #     assert(response(conn, 204) == "")

  #     todos = Repo.all(Todos.Todo)
  #     assert(length(todos) == 0)
  # end
end
