defmodule FullStackorySlackWeb.Stripe.CustomerView do
  @moduledoc """
  View module rendering json payloads for Stripe.CustomerController
  """
  use FullStackorySlackWeb, :view

  def render("create.json", %{message: msg}) do
    %{message: msg}
  end
end
