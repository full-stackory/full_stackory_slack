defmodule FullStackorySlackWeb.Stripe.SubscriptionControllerTest do
  use FullStackorySlackWeb.WebhookCase

  test "returns 200 status for handled action", %{conn: conn} do
    {conn, payload} = conn |> create_request("customer.subscription.created")
    conn = post(conn, "/stripe/subscription", payload)

    refute conn |> json_response(200) |> is_nil()
  end

  test "returns 500 status for unhandled action", %{conn: conn} do
    {conn, payload} = conn |> create_request("customer.subscription.trogdor")
    conn = post(conn, "/stripe/subscription", payload)

    refute conn |> json_response(500) |> is_nil()
  end
end
