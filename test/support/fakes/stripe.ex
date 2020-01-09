defmodule Fakes.Stripe.Plan do
  def list(%{active: true}, expand: ["data.product"]) do
    {:ok, %{data: []}}
  end
end
