defmodule FullStackorySlackWeb.CacheBodyReader do
  @moduledoc """
  Module utilized in our Phoenix endpoint that caches the raw body into 
  `Plug.conn.assigns[:raw_body]`. This is necessary for us to use signature
  headers and verify that payloads are accurate for our webhooks.
  """
  @moduledoc since: "0.0.1"

  @doc """
  Function utilized in Plug.Parsers that reads in a raw body and stores it in
  an assigns key.
  """
  @spec read_body(Plug.Conn.t(), list) :: {:ok, String.t(), Plug.Conn.t()}
  def read_body(conn, _opts) do
    {:ok, body, read_conn} = Plug.Conn.read_body(conn)
    updated_conn = update_in(read_conn.assigns[:raw_body], &[body | &1 || []])
    {:ok, body, updated_conn}
  end
end
