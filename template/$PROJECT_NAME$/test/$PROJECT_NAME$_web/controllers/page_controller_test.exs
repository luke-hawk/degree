defmodule <%= @project_name_camel_case %>Web.PageControllerTest do
  use <%= @project_name_camel_case %>Web.ConnCase

  describe "dynamic page controller" do
    alias <%= @project_name_camel_case %>.Accounts
    alias <%= @project_name_camel_case %>.Repo

    @valid_attrs %{password: "somePassword", password_confirmation: "somePassword", email: "some@email.com", name: "Some Name", role: "admin"}
    @params %{email: "some@email.com", password: "somePassword"} 
    @dynamic_page_attrs %{ slug: "/blog/test-post", title: "Blog | Test", template: "blog.html" }

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      Accounts.get_user(user.id)
    end

    def page_fixture(_attrs \\ %{}) do
      {:ok, page} =
        %Thesis.Page{}
        |> Thesis.Page.changeset(@dynamic_page_attrs)
        |> Repo.insert()

      page
    end

  	test "GET /admin/pages", %{conn: conn} do
  		user_fixture()
  		conn = post(conn, Routes.session_path(conn, :create), session: @params)
      page = page_fixture()
  		conn = get(conn, Routes.pages_path(conn, :index))
      assert html_response(conn, 200) =~ page.slug
  	end

    test "DELETE /admin/pages/:id", %{conn: conn} do
      user_fixture()
      conn = post(conn, Routes.session_path(conn, :create), session: @params)
      page = page_fixture()
      conn = delete(conn, Routes.pages_path(conn, :delete_page, page.id))
      assert get_flash(conn, :info) == "Page deleted successfully."
      assert redirected_to(conn) == Routes.pages_path(conn, :index)
    end

    test "GET /*path", %{conn: conn} do
      user_fixture()
      conn = post(conn, Routes.session_path(conn, :create), session: @params)
      page = page_fixture()
      conn = get(conn, "/blog/test-post")
      assert html_response(conn, 200) =~ page.title
    end
  end
end
