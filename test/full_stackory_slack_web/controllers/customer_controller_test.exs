defmodule FullStackorySlackWeb.Stripe.CustomerControllerTest do
  use FullStackorySlackWeb.WebhookCase

  @event_object %{
    name: "PH",
    email: "ph@t.com",
    description: "AD",
    id: "a"
  }

  test "returns 200 status for handled action", %{conn: conn} do
    {updated_conn, payload} = create_request(conn, "customer.created", @event_object)

    refute updated_conn
           |> post("/stripe/customer", payload)
           |> json_response(200)
           |> is_nil()
  end

  test "returns 500 status for unhandled action", %{conn: conn} do
    {updated_conn, payload} = create_request(conn, "customer.trogdor")

    refute updated_conn
           |> post("/stripe/customer", payload)
           |> json_response(500)
           |> is_nil()
  end
end
