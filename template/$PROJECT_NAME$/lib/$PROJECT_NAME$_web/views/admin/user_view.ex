defmodule <%= @project_name_camel_case %>Web.Admin.UserView do
  use <%= @project_name_camel_case %>Web, :view

  def render("user.json", %{user: user}) do
    %{id: user.id, username: user.name}
  end
end
