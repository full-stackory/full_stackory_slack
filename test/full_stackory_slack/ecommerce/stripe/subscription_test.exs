defmodule FullStackorySlack.Ecommerce.Stripe.SubscriptionTest do
  use FullStackorySlack.DataCase

  alias FullStackorySlack.Ecommerce.Stripe.Subscription

  test "handles `customer.subscription.created` event successfully" do
    event = create_event("customer.subscription.created")
    assert {:ok, "Successfully handled event", event} == event |> Subscription.handle_event()
  end

  test "handles `customer.subscription.updated` event successfully" do
    event = create_event("customer.subscription.updated")
    assert {:ok, "Successfully handled event", event} == event |> Subscription.handle_event()
  end

  test "handles `customer.subscription.trial_will_end` event successfully" do
    event = create_event("customer.subscription.trial_will_end")
    assert {:ok, "Successfully handled event", event} == event |> Subscription.handle_event()
  end

  test "handles `customer.subscription.deleted` event successfully" do
    event = create_event("customer.subscription.deleted")
    assert {:ok, "Successfully handled event", event} == event |> Subscription.handle_event()
  end

  test "handles non identified events with error" do
    event = create_event("customer.subscription.trogdor")

    assert {:error, "Unhandled event type: #{event.type} sent", event} ==
             event |> Subscription.handle_event()
  end
end
