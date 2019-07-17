defmodule <%= @project_name_camel_case %>.ThesisAuth do
  @moduledoc """
  Contains functions for handling Thesis authorization.
  """
  import Plug.Conn

  @behaviour Thesis.Auth

  def page_is_editable?(conn) do
    
    case verify_session(conn) do
      {:ok, _success} ->
        true
      {:error, _error} ->
        false
    end
  end

  defp verify_session(conn) do
    conn
    |> get_session(:guardian_admin_token)
    |> <%= @project_name_camel_case %>.Auth.Guardian.decode_and_verify
  end
end