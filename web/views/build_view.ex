defmodule Benches.BuildView do
  use Benches.Web, :view

  def render("index.json", %{builds: builds}) do
    %{data: render_many(builds, "build.json")}
  end

  def render("show.json", %{build: build}) do
    %{data: render_one(build, "build.json")}
  end

  def render("build.json", %{build: build}) do
    %{id: build.id}
  end
end
