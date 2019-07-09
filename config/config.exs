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

# %% Coherence Configuration %%   Don't remove this line
config :coherence,
  user_schema: Degree.Coherence.User,
  repo: Degree.Repo,
  module: Degree,
  web_module: DegreeWeb,
  router: DegreeWeb.Router,
  password_hashing_alg: Comeonin.Bcrypt,
  messages_backend: DegreeWeb.Coherence.Messages,
  registration_permitted_attributes: [
    "email",
    "name",
    "password",
    "current_password",
    "password_confirmation"
  ],
  invitation_permitted_attributes: ["name", "email"],
  password_reset_permitted_attributes: [
    "reset_password_token",
    "password",
    "password_confirmation"
  ],
  require_current_password: false,
  session_permitted_attributes: ["remember", "email", "password"],
  email_from_name: "Lucas",
  email_from_email: "info@degree-cms.com",
  opts: [:authenticatable, :invitable],
  layout: { DegreeWeb.LayoutView, :admin }

config :coherence, DegreeWeb.Coherence.Mailer,
  adapter: Swoosh.Adapters.Sendgrid,
  api_key: "your api key here"

# %% End Coherence Configuration %%