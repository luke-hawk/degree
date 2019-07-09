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

  pipeline :admin_layout do
    plug :put_layout, { DegreeWeb.LayoutView, :admin }
  end

  # PUBLIC ADMIN ROUTES 
  scope "/admin" do
    pipe_through([:browser, :admin_layout])
    coherence_routes()
  end

  # PROTECTED ADMIN ROUTES 
  scope "/admin" do
    pipe_through([:protected, :admin_layout])
    coherence_routes(:protected)
  end

  # PROTECTED ROUTES
  scope "/admin", DegreeWeb do
    pipe_through([:protected, :admin_layout])

    get "/", AdminController, :index
    get "/pages", AdminController, :index_pages
    delete "/pages/:route_id", AdminController, :delete_page
    resources "/user", UserController, except: [:show]
  end

  # PUBLIC ROUTES
  scope "/", DegreeWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/*path", PageController, :dynamic
  end
end
