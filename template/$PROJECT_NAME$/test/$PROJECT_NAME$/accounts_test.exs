defmodule <%= @project_name_camel_case %>.AccountsTest do
  use <%= @project_name_camel_case %>.DataCase

  alias <%= @project_name_camel_case %>.Accounts

  describe "users" do
    alias <%= @project_name_camel_case %>.Accounts.User

    @valid_attrs %{password: "somePassword", password_confirmation: "somePassword", email: "some@email.com", name: "Some Name", role: "admin"}
    @invalid_attrs %{password: nil, email: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      Accounts.get_user(user.id)
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert String.contains?(user.password_hash, "$") 
      assert user.email == "some@email.com"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, _} = Accounts.create_user(@invalid_attrs)
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user_registration(user)
    end
  end
end