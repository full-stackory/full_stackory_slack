defmodule FullStackorySlack.Ecommerce.Stripe.Customer do
  @moduledoc """
  Module that handles Customer events and applies various business logic for
  said events.
  """
  @moduledoc since: "0.0.1"

  alias FullStackorySlack.Ecommerce.EventHandler
  alias FullStackorySlack.Accounts

  @behaviour EventHandler
  @success_handle_msg "Successfully handled event"

  @doc """
  """
  @doc since: "0.0.1"
  @impl EventHandler
  @spec handle_event(Stripe.Event.t()) :: {atom, String.t(), Stripe.Event.t()}
  def handle_event(%Stripe.Event{type: "customer.created"} = event) do
    event
    |> transform_to_map()
    |> Accounts.create_customer()
    |> handle_result(event)
  end

  def handle_event(%Stripe.Event{type: "customer.updated"} = event) do
    event
    |> transform_to_map()
    |> Accounts.update_customer()
    |> handle_result(event)
  end

  def handle_event(%Stripe.Event{type: "customer.deleted"} = event) do
    event
    |> transform_to_map()
    |> Accounts.mark_for_deletion()
    |> handle_result(event)
  end

  def handle_event(event) do
    {:error, "Unhandled event type: #{event.type} sent", event}
  end

  defp handle_result({:ok, _customer}, event) do
    {:ok, @success_handle_msg, event}
  end

  defp handle_result({:error, customer}, event) do
    {:error, "Customer not created. #{customer.errors}", event}
  end

  defp transform_to_map(event) do
    %{
      email: event.data.object.email,
      stripe_id: event.data.object.id,
      name: event.data.object.name,
      description: event.data.object.description
    }
  end
end
