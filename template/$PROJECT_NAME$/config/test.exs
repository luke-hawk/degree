use Mix.Config

# Configure your database
config :<%= @project_name %>, <%= @project_name_camel_case %>.Repo,
  username: "postgres",
  password: "postgres",
  database: "<%= @project_name %>_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :<%= @project_name %>, <%= @project_name_camel_case %>Web.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
