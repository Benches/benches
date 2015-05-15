defmodule Benches.PageController do
  use Benches.Web, :controller

  plug :action

  def index(conn, _params) do
    render conn, "index.html"
  end
end
