defmodule <%= @project_name_camel_case %>Web.WebPageControllerTest do
  use <%= @project_name_camel_case %>Web.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Default Title"
  end
end
