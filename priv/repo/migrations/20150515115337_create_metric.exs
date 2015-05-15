defmodule Benches.Repo.Migrations.CreateMetric do
  use Ecto.Migration

  def change do
    create table(:metrics) do
      add :key, :string
      add :value, :decimal
      add :build_id, :integer

      timestamps
    end
    create index(:metrics, [:build_id])

  end
end
