defmodule FullStackorySlackWeb.Stripe.CustomerController do
  @moduledoc """
  Controller that handles webhook POST requests from Stripe that manipulate the
  Customer domain.
  """

  use FullStackorySlackWeb, :controller
  alias FullStackorySlack.Ecommerce.Stripe.Customer

  @doc """
  Handle all supported customer actions sent to this controller. This list can
  be found in `FullStackorySlack.Customer` module.
  """
  @spec create(Plug.Conn.t(), any()) :: Plug.Conn.t()
  def create(conn, _params) do
    conn.assigns[:event]
    |> Customer.handle_event()
    |> send_response(conn)
  end

  defp send_response({:ok, msg, _event}, conn) do
    conn |> put_status(:ok) |> render("create.json", message: msg)
  end

  defp send_response({:error, msg, event}, conn) do
    conn
    |> put_status(:internal_server_error)
    |> render("create.json", message: msg)
  end
end
