defmodule Degree.ThesisAuth do
  @moduledoc """
  Contains functions for handling Thesis authorization.
  """
  import Plug.Conn
  import Logger

  @behaviour Thesis.Auth

  def page_is_editable?(conn) do
    
    case verify_session(conn) do
      {:ok, success} ->
        true
      {:error, error} ->
        false
    end
  end

  defp verify_session(conn) do
    conn
    |> get_session(:guardian_admin_token)
    |> Degree.Auth.Guardian.decode_and_verify
  end
end