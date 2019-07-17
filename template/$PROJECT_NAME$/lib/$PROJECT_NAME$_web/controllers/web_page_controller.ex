defmodule <%= @project_name_camel_case %>Web.WebPageController do
  use <%= @project_name_camel_case %>Web, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def dynamic(conn, _params) do
  	if <%= @project_name_camel_case %>Web.SessionController.logged_in?(conn) || conn.assigns.thesis_page.published do
  		render_dynamic(conn)
  	else
  		conn
	    |> put_status(:not_found)
	    |> put_view(<%= @project_name_camel_case %>Web.ErrorView)
	    |> render(:"404")
  	end
  end
end
