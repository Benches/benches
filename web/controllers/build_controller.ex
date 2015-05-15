defmodule Benches.BuildController do
  use Benches.Web, :controller

  alias Benches.Build

  plug :scrub_params, "build" when action in [:create, :update]
  plug :action

  def index(conn, _params) do
    builds = Repo.all(Build)
    render(conn, "index.json", builds: builds)
  end

  def create(conn, %{"build" => build_params}) do
    changeset = Build.changeset(%Build{}, build_params)

    if changeset.valid? do
      build = Repo.insert(changeset)
      render(conn, "show.json", build: build)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(Benches.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    build = Repo.get(Build, id)
    render conn, "show.json", build: build
  end

  def update(conn, %{"id" => id, "build" => build_params}) do
    build = Repo.get(Build, id)
    changeset = Build.changeset(build, build_params)

    if changeset.valid? do
      build = Repo.update(changeset)
      render(conn, "show.json", build: build)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(Benches.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    build = Repo.get(Build, id)

    build = Repo.delete(build)
    render(conn, "show.json", build: build)
  end
end
