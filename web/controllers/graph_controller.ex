defmodule Benches.GraphController do
  use Benches.Web, :controller

  alias Benches.Build
  alias Benches.Metric

  plug :scrub_params, "build" when action in [:create, :update]
  plug :action

  def show(conn, %{"project" => project, "branch" => branch}) do
    metrics = from(m in Metric,
      join: b in Build, on: m.build_id == b.id,
      where: b.project == ^project and b.branch == ^branch,
      select: m,
      order_by: [desc: :id],
      limit: 10)
    |> Repo.all
    |> Enum.group_by(fn(x) -> x.key end)
    |> Enum.map(fn({k, metrics}) -> %{series: k, values: Enum.map(metrics, fn(x) -> {v, _} = Float.parse(Decimal.to_string(x.value)); v end)} end)

    content = Poison.encode!([%{"datum" => metrics}])
    |> IO.inspect

    result = HTTPoison.post("https://frozen-ridge-7727.herokuapp.com/line",
      content,
      %{"Content-Type" => "application/json"})
      |> IO.inspect

    case result do
      {:ok, %HTTPoison.Response{body: body}} ->
        conn
        |> put_resp_content_type("image/svg+xml")
        |> send_resp(200, body)
      _ -> IO.inspect(result)
    end
  end
end
