defmodule DegreeWeb.AdminController do
  use DegreeWeb, :controller
  
  def index(conn, _params) do
    render(conn, "index.html")
  end
end
