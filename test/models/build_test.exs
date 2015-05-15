defmodule Benches.BuildTest do
  use Benches.ModelCase

  alias Benches.Build

  @valid_attrs %{branch: "some content", commit_sha: "some content", commit_timestamp: %{day: 17, hour: 14, min: 0, month: 4, year: 2010}, project: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Build.changeset(%Build{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Build.changeset(%Build{}, @invalid_attrs)
    refute changeset.valid?
  end
end
