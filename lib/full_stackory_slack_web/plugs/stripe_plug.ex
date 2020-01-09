defmodule FullStackorySlackWeb.Plugs.StripePlug do
  @behaviour Plug

  @moduledoc """
  Plug that handles stripe webhooks. If the request is not a stripe webhook
  it just passes through unaltered.

  This plug is put above Plug.Parsers in the Endpoint module.
  """
  import Plug.Conn

  @secret Application.get_env(:full_stackory_slack, :stripe_http_secret)

  @doc false
  @impl true
  def init(options), do: options

  @doc """
  Function that verifies the request_path matches a route listening for
  stripe webhooks. On verification, then runs verification on the payload
  using `stripe-signature` header, `STRIPE_HTTP_SECRET` and `read_body(conn)`
  """
  @impl true
  def call(conn, _opts), do: verify_request(conn)

  defp verify_request(conn) do
    do_verify({conn.assigns[:raw_body], conn})
  end

  defp do_verify({body, conn}) do
    [signature] = get_req_header(conn, "stripe-signature")

    body
    |> Stripe.Webhook.construct_event(signature, @secret)
    |> handle_stripe_event(conn)
  end

  defp handle_stripe_event({:ok, event}, conn) do
    assign(conn, :event, event)
  end

  defp handle_stripe_event({:error, _err}, conn) do
    conn
    |> send_resp(:bad_request, "Webhook Not Verified")
    |> halt()
  end
end
