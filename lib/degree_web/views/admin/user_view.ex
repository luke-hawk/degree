defmodule DegreeWeb.Admin.UserView do
  use DegreeWeb, :view

  def render("user.json", %{user: user}) do
    %{id: user.id, username: user.name}
  end
end
