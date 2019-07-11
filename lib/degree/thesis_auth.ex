defmodule Degree.ThesisAuth do
  @moduledoc """
  Contains functions for handling Thesis authorization.
  """
  @behaviour Thesis.Auth

  def page_is_editable?(_conn) do
  	true
  end
end
