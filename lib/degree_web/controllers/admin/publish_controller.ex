defmodule DegreeWeb.Admin.PublishController do
  use DegreeWeb, :controller

  alias Degree.Repo
  
  def index(conn, _params) do
    render(conn, "index.html", routes: Thesis.Page |> Repo.all)
  end

  def publish(conn, %{"route_id" => route_id, "published" => published  } = params) do
    page = Repo.get(Thesis.Page, route_id)
    changeset = Thesis.Page.changeset(page, params)

    if changeset.valid? do
      Repo.update(changeset)

      conn
      |> put_flash(:info, "Page published successfully..")
      |> redirect(to: Routes.publish_path(conn, :index))
    end
  end

  def unpublish(conn, %{"route_id" => route_id, "published" => published  } = params) do
    page = Repo.get(Thesis.Page, route_id)
    changeset = Thesis.Page.changeset(page, params)

    if changeset.valid? do
      Repo.update(changeset)

      conn
      |> put_flash(:info, "Page unpublished successfully..")
      |> redirect(to: Routes.publish_path(conn, :index))
    end
  end
end
