defmodule DegreeWeb.Router do
  use DegreeWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug(Degree.Auth.AuthAccessPipeline)
  end

  pipeline :protected do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
    # auth plug
  end

  pipeline :admin_layout do
    plug :put_layout, { DegreeWeb.LayoutView, :admin }
  end

  # PROTECTED ADMIN ROUTES
  scope "/admin", DegreeWeb do
    pipe_through([:protected, :auth, :admin_layout])

    get "/", AdminController, :index
    get "/pages", AdminController, :index_pages
    delete "/pages/:route_id", AdminController, :delete_page
    resources "/user", Admin.UserController, except: [:show]
    delete "/sessions", SessionController, :delete
  end

  # PUBLIC ADMIN ROUTES
  scope "/admin", DegreeWeb do
    pipe_through([:protected, :admin_layout])

    resources("/sessions", SessionController, only: [:new, :create])
  end

  # PUBLIC ROUTES
  scope "/", DegreeWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/*path", PageController, :dynamic
  end
end
