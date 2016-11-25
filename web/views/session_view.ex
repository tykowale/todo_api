defmodule Todos.SessionView do
    use Todos.Web, :view

    def render("show.json", %{session: session}) do
        %{
            data: session_json(session)
        }
    end

    def render("error.json", _params) do
        %{errors: "failed to authenticate"}
    end

    defp session_json(session) do
        %{
            token: session.token
        }
    end
end
