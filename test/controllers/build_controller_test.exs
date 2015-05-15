defmodule Benches.BuildControllerTest do
  use Benches.ConnCase

  alias Benches.Build
  @valid_params build: %{branch: "some content", commit_sha: "some content", commit_timestamp: %{day: 17, hour: 14, min: 0, month: 4, year: 2010}, project: "some content"}
  @invalid_params build: %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "GET /builds", %{conn: conn} do
    conn = get conn, build_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "GET /builds/:id", %{conn: conn} do
    build = Repo.insert %Build{}
    conn = get conn, build_path(conn, :show, build)
    assert json_response(conn, 200)["data"] == %{
      "id" => build.id
    }
  end

  test "POST /builds with valid data", %{conn: conn} do
    conn = post conn, build_path(conn, :create), @valid_params
    assert json_response(conn, 200)["data"]["id"]
  end

  test "POST /builds with invalid data", %{conn: conn} do
    conn = post conn, build_path(conn, :create), @invalid_params
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "PUT /builds/:id with valid data", %{conn: conn} do
    build = Repo.insert %Build{}
    conn = put conn, build_path(conn, :update, build), @valid_params
    assert json_response(conn, 200)["data"]["id"]
  end

  test "PUT /builds/:id with invalid data", %{conn: conn} do
    build = Repo.insert %Build{}
    conn = put conn, build_path(conn, :update, build), @invalid_params
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "DELETE /builds/:id", %{conn: conn} do
    build = Repo.insert %Build{}
    conn = delete conn, build_path(conn, :delete, build)
    assert json_response(conn, 200)["data"]["id"]
    refute Repo.get(Build, build.id)
  end
end
