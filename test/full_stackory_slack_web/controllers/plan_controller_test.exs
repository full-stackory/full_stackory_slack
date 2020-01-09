defmodule FullStackorySlackWeb.Stripe.PlanControllerTest do
  use FullStackorySlackWeb.WebhookCase

  test "returns 200 for handled action", %{conn: conn} do
    {conn, payload} = conn |> create_request("plan.created")
    conn = post(conn, "/stripe/plan", payload)

    refute conn |> json_response(200) |> is_nil()
  end

  test "returns 500 for unhandled action", %{conn: conn} do
    {conn, payload} = conn |> create_request("plan.trogdor")
    conn = post(conn, "/stripe/plan", payload)

    refute conn |> json_response(500) |> is_nil()
  end
end
