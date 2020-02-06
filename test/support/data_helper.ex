defmodule FullStackorySlack.DataHelper do
  def create_event(action, object_attrs \\ %{}) do
    %Stripe.Event{
      type: action,
      data: %{
        object: object_attrs
      }
    }
  end
end
