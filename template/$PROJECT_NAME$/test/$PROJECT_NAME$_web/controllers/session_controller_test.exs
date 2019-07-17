defmodule <%= @project_name_camel_case %>Web.SessionControllerTest do
  use <%= @project_name_camel_case %>Web.ConnCase

  describe "sessions controller" do
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

    test "GET /admin/sessions/new", %{conn: conn} do
	    conn = get(conn, Routes.session_path(conn, :new))
	    assert html_response(conn, 200) =~ "Sign In"
  	end

  	test "POST /admin/sessions", %{conn: conn} do
  		user = user_fixture()
  		conn = post(conn, Routes.session_path(conn, :create), session: @params)
  		assert get_flash(conn, :info) == "Welcome back!"
  		assert redirected_to(conn) == Routes.admin_path(conn, :index)
  		assert conn.assigns.current_user == user
  	end

  	test "DELETE /admin/sessions", %{conn: conn} do
  		user = user_fixture()
  		conn = post(conn, Routes.session_path(conn, :create), session: @params)
  		assert conn.assigns.current_user == user
  		conn = delete(conn, Routes.session_path(conn, :delete))
  		assert redirected_to(conn) == Routes.web_page_path(conn, :index)
  		assert Map.has_key?(conn.assigns, :current_user) == false
  	end
  end
end
