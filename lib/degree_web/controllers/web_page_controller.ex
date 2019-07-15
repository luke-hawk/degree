defmodule DegreeWeb.WebPageController do
  use DegreeWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def dynamic(conn, _params) do
  	if DegreeWeb.SessionController.logged_in?(conn) || conn.assigns.thesis_page.published do
  		render_dynamic(conn)
  	else
  		conn
	    |> put_status(:not_found)
	    |> put_view(DegreeWeb.ErrorView)
	    |> render(:"404")
  	end
  end
end
