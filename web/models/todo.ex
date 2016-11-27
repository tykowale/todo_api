defmodule Todos.Todo do
  use Todos.Web, :model
  import Ecto.Changeset

  schema "todos" do
    field :title
    field :description
    field :owner_id, :integer

    timestamps
  end

  def changeset(todo, params \\ %{}) do
    todo
    |> cast(params, [:title, :description, :owner_id])
    |> validate_required([:title, :owner_id])
  end
end
