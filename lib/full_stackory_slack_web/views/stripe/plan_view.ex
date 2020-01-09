defmodule FullStackorySlackWeb.Stripe.PlanView do
  @moduledoc """
  View module rendering json payloads for Stripe.PlanController
  """
  use FullStackorySlackWeb, :view

  def render("create.json", %{message: msg}) do
    %{message: msg}
  end
end
