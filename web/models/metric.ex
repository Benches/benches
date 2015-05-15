defmodule Benches.Metric do
  use Benches.Web, :model

  schema "metrics" do
    field :key, :string
    field :value, :decimal
    belongs_to :build, Benches.Build

    timestamps
  end

  @required_fields ~w(build_id key value)
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
