defmodule Degree.ThesisAuth do
  @moduledoc """
  Contains functions for handling Thesis authorization.
  """
  @behaviour Thesis.Auth

  def page_is_editable?(conn) do
  	conn
  	|> IO.inspect(label: "Connection")
  	|> Coherence.logged_in?
  end
end
