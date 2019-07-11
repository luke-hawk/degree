defmodule Degree.Auth.AuthErrorHandler do
  @moduledoc false

  import Plug.Conn
  import Phoenix.Controller, only: [redirect: 2]

  def auth_error(conn, {_type, _reason}, _opts) do
  	conn
      |> redirect(to: "/admin/sessions/new")
  end
end
