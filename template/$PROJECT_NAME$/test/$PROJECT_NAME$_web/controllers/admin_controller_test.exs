defmodule <%= @project_name_camel_case %>Web.AdminControllerTest do
  use <%= @project_name_camel_case %>Web.ConnCase

  describe "admin controller" do
    alias <%= @project_name_camel_case %>.Accounts

    @valid_attrs %{password: "somePassword", password_confirmation: "somePassword", email: "some@email.com", name: "Some Name", role: "admin"}
    @params %{email: "some@email.com", password: "somePassword"} 

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      Accounts.get_user(user.id)
    end

  	test "GET /admin", %{conn: conn} do
  		user = user_fixture()
  		conn = post(conn, Routes.session_path(conn, :create), session: @params)
  		assert get_flash(conn, :info) == "Welcome back!"
  		assert redirected_to(conn) == Routes.admin_path(conn, :index)
  		assert conn.assigns.current_user == user
  	end
  end
end
