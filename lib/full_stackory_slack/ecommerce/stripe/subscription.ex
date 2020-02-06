defmodule FullStackorySlack.Ecommerce.Stripe.Subscription do
  @moduledoc """
  Module that handles Subscription events and applies various business logic for
  said events.
  """
  @moduledoc since: "0.0.1"

  alias FullStackorySlack.Ecommerce.EventHandler

  @behaviour EventHandler
  @success_handle_msg "Successfully handled event"

  @doc """
  """
  @doc since: "0.0.1"
  @spec handle_event(Stripe.Event.t()) :: {atom, String.t(), Stripe.Event.t()}
  @impl EventHandler
  def handle_event(%Stripe.Event{type: "customer.subscription.created"} = event) do
    {:ok, @success_handle_msg, event}
  end

  def handle_event(%Stripe.Event{type: "customer.subscription.updated"} = event) do
    {:ok, @success_handle_msg, event}
  end

  def handle_event(%Stripe.Event{type: "customer.subscription.trial_will_end"} = event) do
    {:ok, @success_handle_msg, event}
  end

  def handle_event(%Stripe.Event{type: "customer.subscription.deleted"} = event) do
    {:ok, @success_handle_msg, event}
  end

  def handle_event(event) do
    {:error, "Unhandled event type: #{event.type} sent", event}
  end
end
