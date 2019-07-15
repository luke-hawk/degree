defmodule Degree.Auth.ErrorHandler do
  @moduledoc false

  import Phoenix.Controller, only: [redirect: 2]

  def auth_error(conn, {_type, _reason}, _opts) do
  	conn
      |> redirect(to: "/admin/sessions/new")
  end
end
