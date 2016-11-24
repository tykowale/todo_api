defmodule Todos.UserController do
  use Todos.Web, :controller
  alias Todos.User

  def create(conn, _params) do
    conn
    |> send_resp(200, [])
  end
end
