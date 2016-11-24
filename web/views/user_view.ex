defmodule Todos.UserView do
    use Todos.Web, :view

    def render("show.json", %{user: user}) do
        %{user: user_json(user)}
    end

    def user_json(user) do
        %{
            id: user.id,
            email: user.email
        }
    end
end
