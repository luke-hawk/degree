defmodule Degree.ThesisAuth do
  @moduledoc """
  Contains functions for handling Thesis authorization.
  """
  @behaviour Thesis.Auth

  def page_is_editable?(conn) do
    IO.inspect(Guardian.Plug.current_resource(conn))

  	true
  end
end
