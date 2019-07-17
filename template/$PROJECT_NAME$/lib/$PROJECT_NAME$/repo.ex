defmodule <%= @project_name_camel_case %>.Repo do
  use Ecto.Repo,
    otp_app: :<%= @project_name %>,
    adapter: Ecto.Adapters.Postgres
end
