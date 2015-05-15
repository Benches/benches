defmodule Benches.Build do
  use Benches.Web, :model

  schema "builds" do
    field :project, :string
    field :branch, :string
    field :commit_timestamp, Ecto.DateTime
    field :commit_sha, :string
    has_many :metrics, Benches.Metric

    timestamps
  end

  @required_fields ~w(project branch commit_timestamp commit_sha)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If `params` are nil, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
