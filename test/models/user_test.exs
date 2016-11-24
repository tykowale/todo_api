defmodule Todos.UserTest do
  use Todos.ModelCase

  alias Todos.User

  @valid_attrs %{unencrypted_password: "some password", email: "ty@foo.com"}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with email too short" do
    changeset = User.changeset(
      %User{}, Map.put(@valid_attrs, :email, "")
    )
    refute changeset.valid?
  end

  test "changeset with invalid email" do
    changeset = User.changeset(
      %User{}, Map.put(@valid_attrs, :email, "tykowale.com")
    )
    refute changeset.valid?
  end

  test "registration_changeste with valid password" do
    changeset = User.registration_changeset(%User{}, @valid_attrs)

    assert changeset.changes.password
    assert changeset.valid?
  end

  test "registration_changset with password too short" do
    changeset = User.registration_changeset(
      %User{}, Map.put(@valid_attrs, :unencrypted_password, "12345")
    )

    refute changeset.valid?
  end
end
