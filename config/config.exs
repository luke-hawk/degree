# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :degree,
  ecto_repos: [Degree.Repo]

# Configures the endpoint
config :degree, DegreeWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "+P5c28HU7PaYspucaRdm4VIKKmCNKRxaI+7mSEl6Pp0DGdyzCbeld657RBF7eKZ0",
  render_errors: [view: DegreeWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Degree.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

# Configures Guardian
config :degree, Degree.Auth.Guardian,
  issuer: "degree",
  secret_key: "HNinpKh9Ne3tr8BpjCpAEh0xzCqTIG3PWsfkR2AtzvUaRIpbs6oIQ9RcmjmGPekJ"

config :degree, Degree.Auth.AuthAccessPipeline,
  module: Degree.Auth.Guardian,
  error_handler: Degree.Auth.AuthErrorHandler

# Thesis Main Config
config :thesis,
  store: Thesis.EctoStore,
  authorization: Degree.ThesisAuth,
  uploader: Thesis.RepoUploader

config :thesis, :dynamic_pages,
  view: DegreeWeb.PageView,
  templates: ["blog.html"],
  not_found_view: DegreeWeb.ErrorView,
  not_found_template: "404.html"

# Thesis Store Config
config :thesis, Thesis.EctoStore, repo: Degree.Repo

# Thesis Notifications Config
# config :thesis, :notifications,
#   add_page: [],
#   page_settings: [],
#   import_export_restore: []


