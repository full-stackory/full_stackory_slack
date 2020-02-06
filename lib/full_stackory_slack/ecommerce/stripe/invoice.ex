defmodule FullStackorySlack.Ecommerce.Stripe.Invoice do
  @moduledoc """
  """
  @moduledoc since: "0.0.1"

  alias FullStackorySlack.Ecommerce.EventHandler

  @behaviour EventHandler

  @success_handle_msg "Successfully handled event"

  @spec handle_event(Stripe.Event.t()) :: {atom, String.t(), Stripe.Event.t()}
  @impl EventHandler
  def handle_event(%Stripe.Event{type: "invoice.created"} = event) do
    {:ok, @success_handle_msg, event}
  end

  def handle_event(%Stripe.Event{type: "invoice.updated"} = event) do
    {:ok, @success_handle_msg, event}
  end

  def handle_event(%Stripe.Event{type: "invoice.deleted"} = event) do
    {:ok, @success_handle_msg, event}
  end

  def handle_event(%Stripe.Event{type: "invoice.payment_failed"} = event) do
    {:ok, @success_handle_msg, event}
  end

  def handle_event(%Stripe.Event{type: "invoice.payment_succeeded"} = event) do
    {:ok, @success_handle_msg, event}
  end

  def handle_event(%Stripe.Event{type: "invoice.upcoming"} = event) do
    {:ok, @success_handle_msg, event}
  end

  def handle_event(event) do
    {:error, "Unhandled event type: #{event.type} sent", event}
  end
end
