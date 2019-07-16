defmodule DegreeWeb.PublishControllerTest do
  use DegreeWeb.ConnCase

  describe "publish controller" do
    alias Degree.Accounts
    alias Degree.Repo

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

  	test "GET /admin/publish", %{conn: conn} do
  		user_fixture()
  		conn = post(conn, Routes.session_path(conn, :create), session: @params)
      page = page_fixture()
  		conn = get(conn, Routes.publish_path(conn, :index))
      assert html_response(conn, 200) =~ page.slug
  	end

    test "PUT /admin/publish/:route_id/publish", %{conn: conn} do
      user_fixture()
      conn = post(conn, Routes.session_path(conn, :create), session: @params)
      page = page_fixture()
      conn = put(conn, Routes.publish_path(conn, :publish, page.id), published: true)
      assert get_flash(conn, :info) == "Page published successfully.."
      assert redirected_to(conn) == Routes.publish_path(conn, :index)
    end

    test "PUT /admin/publish/:route_id/unpublish", %{conn: conn} do
      user_fixture()
      conn = post(conn, Routes.session_path(conn, :create), session: @params)
      page = page_fixture()
      conn = put(conn, Routes.publish_path(conn, :unpublish, page.id), published: false)
      assert get_flash(conn, :info) == "Page unpublished successfully.."
      assert redirected_to(conn) == Routes.publish_path(conn, :index)
    end

    test "Dynamic page is visible when unpublished but admin logged in", %{conn: conn} do
      user_fixture()
      conn = post(conn, Routes.session_path(conn, :create), session: @params)
      page = page_fixture()
      conn = put(conn, Routes.publish_path(conn, :unpublish, page.id), published: false)
      conn = get(conn, "/blog/test-post")
      assert html_response(conn, 200) =~ page.title
    end

    test "Dynamic page is NOT visible when unpublished and admin NOT logged in", %{conn: conn} do
      user_fixture()
      conn = post(conn, Routes.session_path(conn, :create), session: @params)
      page = page_fixture()
      conn = put(conn, Routes.publish_path(conn, :unpublish, page.id), published: false)
      conn = delete(conn, Routes.session_path(conn, :delete))
      assert Map.has_key?(conn.assigns, :current_user) == false
      conn = get(conn, "/blog/test-post")
      assert html_response(conn, 404)
    end
  end
end
