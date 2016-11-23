defmodule Todos.TodoControllerTest do
    use Todos.ConnCase
    alias Todos.TodoView
    alias Todos.Repo

    test "#index renders a list of todos" do
        conn = build_conn()
        todo = insert(:todo)

        conn = get conn, todo_path(conn, :index)

        assert json_response(conn, 200) == render_json(TodoView, "index.json", todos: [todo])
    end

    test "#show renders a single todo" do
        conn = build_conn()
        todo = insert(:todo)

        conn = get conn, todo_path(conn, :show, todo)

        assert json_response(conn, 200) == render_json(TodoView, "show.json", todo: todo)
    end

    test "#create stores properly formatted todos" do
        conn = build_conn()
        todo = %{
            description: "task description",
            title: "Task 1"
        }

        conn = post(conn, todo_path(conn, :create, todo), %{todo: todo})

        response_body = response_body_to_map(conn.resp_body)

        assert json_response(conn, 200) == render_json(TodoView, "show.json", todo: response_body)

        todos = Repo.all(Todos.Todo)
        assert(length(todos) == 1)
    end

    test "#create does not store improperly formatted todos" do
        conn = build_conn()
        todo = %{
            description: "Task 1",
            thing: 2
        }

        conn = post(conn, todo_path(conn, :create, todo), %{todo: todo})
        assert(response(conn, 400) == "")

        todos = Repo.all(Todos.Todo)
        assert(length(todos) == 0)
    end

    test "#delete removes entry by id" do
        conn = build_conn()
        todo = insert(:todo)

        todos = Repo.all(Todos.Todo)
        assert(length(todos) == 1)

        conn = delete(conn, todo_path(conn, :delete, todo))
        assert(response(conn, 204) == "")

        todos = Repo.all(Todos.Todo)
        assert(length(todos) == 0)
    end

    defp response_body_to_map(resp_body) do
        response_body = resp_body |> Poison.decode!

        Enum.reduce(Map.keys(response_body["todo"]), %{}, fn(key, acc) ->
            Map.put(acc, String.to_atom(key), response_body["todo"][key])
        end )
    end
end
