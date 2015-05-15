defmodule Benches.Repo.Migrations.CreateBuild do
  use Ecto.Migration

  def change do
    create table(:builds) do
      add :project, :string
      add :branch, :string
      add :commit_timestamp, :datetime
      add :commit_sha, :string

      timestamps
    end

  end
end
