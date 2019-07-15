defmodule Degree.Repo.Migrations.AddPublishableToThesisPages do
  use Ecto.Migration

  def change do
  	alter table(:thesis_pages) do
      add :published, :boolean, default: false
    end
  end
end
