defmodule <%= @project_name_camel_case %>Web.AdminController do
  use <%= @project_name_camel_case %>Web, :controller
  
  def index(conn, _params) do
    render(conn, "index.html")
  end
end
