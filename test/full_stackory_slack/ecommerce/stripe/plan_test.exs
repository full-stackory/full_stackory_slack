defmodule FullStackorySlack.Ecommerce.Stripe.PlanTest do
  use FullStackorySlack.DataCase

  alias FullStackorySlack.Ecommerce.Stripe.Plan

  test "handles `plan.created` event successfully" do
    event = create_event("plan.created")
    assert {:ok, "Successfully handled event", event} == event |> Plan.handle_event()
  end

  test "handles `plan.updated` event successfully" do
    event = create_event("plan.updated")
    assert {:ok, "Successfully handled event", event} == event |> Plan.handle_event()
  end

  test "handles `plan.deleted` event successfully" do
    event = create_event("plan.deleted")
    assert {:ok, "Successfully handled event", event} == event |> Plan.handle_event()
  end

  test "handles non identified events with error" do
    event = create_event("plan.trogdor")

    assert {:error, "Unhandled event type: #{event.type} sent", event} ==
             event |> Plan.handle_event()
  end
end
