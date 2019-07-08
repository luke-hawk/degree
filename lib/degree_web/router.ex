defmodule DegreeWeb.Router do
  use DegreeWeb, :router
  use Coherence.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug(Coherence.Authentication.Session)
  end

  pipeline :protected do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
    plug(Coherence.Authentication.Session, protected: true)
  end

  scope "/admin" do
    pipe_through(:browser)
    coherence_routes()
  end

  scope "/admin" do
    pipe_through(:protected)
    coherence_routes(:protected)
  end

  # PUBLIC ROUTES
  scope "/", DegreeWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  # PROTECTED ROUTES
  scope "/admin", DegreeWeb do
    pipe_through(:protected)
  end
end
