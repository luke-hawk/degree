defmodule DegreeWeb.Admin.PublishController do
  use DegreeWeb, :controller

  alias Degree.Repo
  use Task
  
  def index(conn, _params) do
    render(conn, "index.html", routes: Thesis.Page |> Repo.all)
  end

  def publish(conn, %{"route_id" => route_id, "published" => _published  } = params) do
    page = Repo.get(Thesis.Page, route_id)
    changeset = Thesis.Page.changeset(page, params)

    if changeset.valid? do
      Repo.update(changeset)

      conn
      |> put_flash(:info, "Page published successfully..")
      |> redirect(to: Routes.publish_path(conn, :index))
      |> generate_sitemap
    end
  end

  def unpublish(conn, %{"route_id" => route_id, "published" => _published  } = params) do
    page = Repo.get(Thesis.Page, route_id)
    changeset = Thesis.Page.changeset(page, params)

    if changeset.valid? do
      Repo.update(changeset)

      conn
      |> put_flash(:info, "Page unpublished successfully..")
      |> redirect(to: Routes.publish_path(conn, :index))
      |> generate_sitemap
    end
  end

  defp generate_sitemap(conn) do
    case Task.start( fn -> Degree.Sitemap.generate() end) do
      {:ok, _pid} ->
        conn
      {:error, _pid} ->
        conn
    end
  end
end
