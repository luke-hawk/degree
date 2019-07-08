defmodule Degree.Repo do
  use Ecto.Repo,
    otp_app: :degree,
    adapter: Ecto.Adapters.Postgres
end
