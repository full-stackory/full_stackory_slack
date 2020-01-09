defmodule FullStackorySlack.Ecommerce.EventHandler do
  @moduledoc """
  Module that defines behaviours for any webhook handler. Currently only vendor
  sending webhooks is Stripe.
  """
  @moduledoc since: "0.0.1"
  @callback handle_event(map) :: {atom, binary, map}
end
