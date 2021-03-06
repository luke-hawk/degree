defmodule <%= @project_name_camel_case %>.AuthTest do
  use <%= @project_name_camel_case %>.DataCase

  alias <%= @project_name_camel_case %>.Auth
  alias <%= @project_name_camel_case %>.Accounts

  describe "users" do

    @valid_attrs %{password: "somePassword", password_confirmation: "somePassword", email: "some@email.com", name: "Some Name", role: "admin"}
    @login_attrs %{email: "some@email.com", password: "somePassword"}
    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      Accounts.get_user(user.id)
    end

    test "authenticate_user validates email and password" do
      user_fixture()
      assert {:ok, _user} = Auth.authenticate_user(@login_attrs.email, @login_attrs.password)
    end
  end
end