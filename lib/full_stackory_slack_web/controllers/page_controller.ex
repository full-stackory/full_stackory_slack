defmodule FullStackorySlackWeb.PageController do
  use FullStackorySlackWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
