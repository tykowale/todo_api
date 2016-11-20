defmodule Todos.Todo do
    use Todos.Web, :model
    import Ecto.Changeset

    schema "todos" do
        field :title
        field :description

        timestamps
    end

    def changeset(todo, params \\ %{}) do
        todo
            |> cast(params, [:title, :description])
            |> validate_required([:title])
    end
end
