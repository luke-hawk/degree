defmodule DegreeWeb.AdminController do
  use DegreeWeb, :controller
  
  alias Degree.Repo

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def index_pages(conn, _params) do
  	render(conn, "index_pages.html", routes: Thesis.Page |> Repo.all)
  end

  def delete_page(conn, %{"route_id" => route_id}) do
  	page = Repo.get(Thesis.Page, route_id)
    Thesis.EctoStore.delete(%{"slug" => page.slug})

    conn
    |> put_flash(:info, "Page deleted successfully.")
    |> redirect(to: Routes.admin_path(conn, :index_pages))
  end
end
