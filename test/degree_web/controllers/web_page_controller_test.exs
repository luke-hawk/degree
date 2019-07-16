defmodule DegreeWeb.WebPageControllerTest do
  use DegreeWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Default Title"
  end
end
