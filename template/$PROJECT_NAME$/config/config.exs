# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :<%= @project_name %>,
  ecto_repos: [<%= @project_name_camel_case %>.Repo]

# Configures the endpoint
config :<%= @project_name %>, <%= @project_name_camel_case %>Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "+P5c28HU7PaYspucaRdm4VIKKmCNKRxaI+7mSEl6Pp0DGdyzCbeld657RBF7eKZ0",
  render_errors: [view: <%= @project_name_camel_case %>Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: <%= @project_name_camel_case %>.PubSub, adapter: Phoenix.PubSub.PG2]

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
config :<%= @project_name %>, <%= @project_name_camel_case %>.Auth.Guardian,
  issuer: "<%= @project_name %>",
  secret_key: "HNinpKh9Ne3tr8BpjCpAEh0xzCqTIG3PWsfkR2AtzvUaRIpbs6oIQ9RcmjmGPekJ"

# Thesis Main Config
config :thesis,
  store: Thesis.EctoStore,
  authorization: <%= @project_name_camel_case %>.ThesisAuth,
  uploader: Thesis.RepoUploader

config :thesis, :dynamic_pages,
  view: <%= @project_name_camel_case %>Web.WebPageView,
  templates: ["blog.html"],
  not_found_view: <%= @project_name_camel_case %>Web.ErrorView,
  not_found_template: "404.html"

# Thesis Store Config
config :thesis, Thesis.EctoStore, repo: <%= @project_name_camel_case %>.Repo

# Thesis Notifications Config
# config :thesis, :notifications,
#   add_page: [],
#   page_settings: [],
#   import_export_restore: []


