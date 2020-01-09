defmodule FullStackorySlack.Ecommerce.Stripe.InvoiceTest do
  use FullStackorySlack.DataCase

  alias FullStackorySlack.Ecommerce.Stripe.Invoice

  test "handles `invoice.created` event successfully" do
    event = create_event("invoice.created")
    assert {:ok, "Successfully handled event", event} == event |> Invoice.handle_event()
  end

  test "handles `invoice.updated` event successfully" do
    event = create_event("invoice.updated")
    assert {:ok, "Successfully handled event", event} == event |> Invoice.handle_event()
  end

  test "handles `invoice.deleted` event successfully" do
    event = create_event("invoice.deleted")
    assert {:ok, "Successfully handled event", event} == event |> Invoice.handle_event()
  end

  test "handles `invoice.payment_failed` event successfully" do
    event = create_event("invoice.payment_failed")
    assert {:ok, "Successfully handled event", event} == event |> Invoice.handle_event()
  end

  test "handles `invoice.payment_succeeded` event successfully" do
    event = create_event("invoice.payment_succeeded")
    assert {:ok, "Successfully handled event", event} == event |> Invoice.handle_event()
  end

  test "handles `invoice.upcoming` event successfully" do
    event = create_event("invoice.upcoming")
    assert {:ok, "Successfully handled event", event} == event |> Invoice.handle_event()
  end

  test "handles non identified events with error" do
    event = create_event("invoice.trogdor")

    assert {:error, "Unhandled event type: #{event.type} sent", event} ==
             event |> Invoice.handle_event()
  end
end
