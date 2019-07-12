defmodule Degree.Auth.Pipeline do
  @moduledoc false

  use Guardian.Plug.Pipeline,
    otp_app: :degree,
    error_handler: Degree.Auth.ErrorHandler,
    module: Degree.Auth.Guardian,
    key: :admin
  # If there is a session token, validate it
  plug Guardian.Plug.VerifySession
  # If there is an authorization header, validate it
  plug Guardian.Plug.VerifyHeader
  # Load the user if either of the verifications worked
  plug Guardian.Plug.LoadResource, allow_blank: true
end
