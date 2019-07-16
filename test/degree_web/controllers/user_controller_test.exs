defmodule DegreeWeb.UserControllerTest do
  use DegreeWeb.ConnCase

  describe "users controller" do
    alias Degree.Accounts

    @valid_attrs %{password: "somePassword", password_confirmation: "somePassword", email: "some@email.com", name: "Some Name", role: "admin"}
    @other_valid_attrs %{password: "someOtherPassword", password_confirmation: "someOtherPassword", email: "someOther@email.com", name: "Some Other Name", role: "admin"}
    @params %{email: "some@email.com", password: "somePassword"} 

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      Accounts.get_user(user.id)
    end

    test "GET /admin/user", %{conn: conn} do
      user = user_fixture()
	    conn = post(conn, Routes.session_path(conn, :create), session: @params)
      conn = get(conn, Routes.user_path(conn, :index))
      assert html_response(conn, 200) =~ user.email
  	end

    test "GET /admin/user/:id/edit", %{conn: conn} do
      user = user_fixture()
      conn = post(conn, Routes.session_path(conn, :create), session: @params)
      conn = get(conn, Routes.user_path(conn, :edit, user.id))
      assert html_response(conn, 200) =~ user.email
    end

    test "GET /admin/user/new", %{conn: conn} do
      user_fixture()
      conn = post(conn, Routes.session_path(conn, :create), session: @params)
      conn = get(conn, Routes.user_path(conn, :new))
      assert html_response(conn, 200) =~ "User"
    end

    test "POST /admin/user", %{conn: conn} do
      user_fixture()
      conn = post(conn, Routes.session_path(conn, :create), session: @params)
      conn = post(conn, Routes.user_path(conn, :create, [user: @other_valid_attrs]))
      assert get_flash(conn, :info) == "User created successfully."
      assert redirected_to(conn) == Routes.user_path(conn, :index)
    end

    test "PUT /admin/user/:id", %{conn: conn} do
      user = user_fixture()
      conn = post(conn, Routes.session_path(conn, :create), session: @params)
      conn = put(conn, Routes.user_path(conn, :update, user.id, [user: %{ name: "New name"}]))
      assert get_flash(conn, :info) == "User updated successfully."
      assert redirected_to(conn) == Routes.user_path(conn, :index)
    end

    test "DELETE /admin/user/:id", %{conn: conn} do
      user = user_fixture()
      conn = post(conn, Routes.session_path(conn, :create), session: @params)
      conn = delete(conn, Routes.user_path(conn, :delete, user.id))
      assert get_flash(conn, :info) == "User deleted successfully."
      assert redirected_to(conn) == Routes.user_path(conn, :index)
    end
  end
end
