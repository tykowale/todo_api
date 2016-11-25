defmodule Todos.UserView do
    use Todos.Web, :view

    def render("index.json", %{users: users}) do
        %{
            users: Enum.map(users, &user_json/1)
        }
    end

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
