defmodule DegreeWeb.PageController do
  use DegreeWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def dynamic(conn, _params) do
    render_dynamic(conn)
  end
end
