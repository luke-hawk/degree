defmodule <%= @project_name_camel_case %>.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false

  alias <%= @project_name_camel_case %>.Repo
  alias <%= @project_name_camel_case %>.Accounts.User

  def list_users do
    User
    |> Repo.all()
  end

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.registration_changeset(attrs)
    |> Repo.insert()
  end

  def get_user(id) do
    User
    |> Repo.get(id)
  end

  def change_user_registration(%User{} = user) do
    User.registration_changeset(user, %{})
  end
end
