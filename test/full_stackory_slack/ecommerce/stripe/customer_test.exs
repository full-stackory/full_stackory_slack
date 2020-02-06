defmodule FullStackorySlack.Ecommerce.Stripe.CustomerTest do
  use FullStackorySlack.DataCase

  alias FullStackorySlack.Ecommerce.Stripe.Customer
  @event_object %{email: "asd@gm.com", name: "PH", description: "a", id: "1"}

  test "handles `customer.created` event successfully" do
    event = create_event("customer.created", @event_object)
    assert {:ok, "Successfully handled event", event} == Customer.handle_event(event)
  end

  test "handles `customer.updated` event successfully" do
    "customer.created"
    |> create_event(@event_object)
    |> Customer.handle_event()

    event = create_event("customer.updated", %{@event_object | name: "NEW"})
    assert {:ok, "Successfully handled event", event} == Customer.handle_event(event)
  end

  test "handles `customer.deleted` event successfully" do
    "customer.created"
    |> create_event(@event_object)
    |> Customer.handle_event()

    event = create_event("customer.deleted", @event_object)
    assert {:ok, "Successfully handled event", event} == Customer.handle_event(event)
  end

  test "handles non identified events with error" do
    event = create_event("customer.trogdor")

    assert {:error, "Unhandled event type: #{event.type} sent", event} ==
             Customer.handle_event(event)
  end
end
