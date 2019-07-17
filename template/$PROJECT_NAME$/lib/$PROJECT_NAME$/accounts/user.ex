defmodule <%= @project_name_camel_case %>.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  @moduledoc false

  schema "users" do
    field(:name, :string)
    field(:email, :string)
    field(:role, :string)
    field(:password_hash, :string)
    field(:password, :string, virtual: true)
    field(:password_confirmation, :string, virtual: true)

    timestamps()
  end

  @doc false
  @spec changeset(Ecto.Schema.t(), Map.t()) :: Ecto.Changeset.t()
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, ~w(name email role)a)
    |> validate_required([:name, :email])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
  end

  def registration_changeset(model, params) do
    model
    |> changeset(params)
    |> cast(params, ~w(password password_confirmation)a, [])
    |> validate_length(:password, min: 6, max: 100)
    |> validate_confirmation(:password)
    |> put_pass_hash()
  end

  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Argon2.hash_pwd_salt(pass))
      _ -> 
        changeset  
    end
  end
end
