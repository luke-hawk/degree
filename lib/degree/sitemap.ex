defmodule Degree.Sitemap do
  alias DegreeWeb.{Endpoint}
  alias Degree.Repo

  import Ecto.Query, only: [from: 2]

  use Sitemap,
    host: "http://#{Application.get_env(:degree, Endpoint)[:url][:host]}",
    files_path: "priv/static/sitemaps/",
    public_path: "sitemaps/"

  def generate do
    create do
      Enum.each dynamic_routes(), fn route -> 
	      add route
	    end
    end
    ping()
  end

  defp dynamic_routes() do
  	from(page in Thesis.Page, where: page.published == true, select: page.slug)
	|> Repo.all()
  end
end