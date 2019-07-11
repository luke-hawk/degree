defmodule Degree.Repo.Migrations.AddRolesToUsers do
  use Ecto.Migration

  def change do
  	alter table(:users) do
      add :role, :string, default: "editor"
    end
  end
end
