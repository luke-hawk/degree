defmodule DegreeWeb.Admin.PagesController do
  use DegreeWeb, :controller

  alias Degree.Repo
  
  def index(conn, _params) do
    render(conn, "index.html", routes: Thesis.Page |> Repo.all)
  end

  def delete_page(conn, %{"route_id" => route_id}) do
    page = Repo.get(Thesis.Page, route_id)
    Thesis.EctoStore.delete(%{"slug" => page.slug})

    conn
    |> put_flash(:info, "Page deleted successfully.")
    |> redirect(to: Routes.pages_path(conn, :index))
  end
  
end
