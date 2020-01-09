defmodule FullStackorySlackWeb.WebhookCase do
  @moduledoc """
  Testing case that introduces functionality to easily test Stripe Webhooks.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      # Import conveniences for testing with connections
      use Phoenix.ConnTest
      alias FullStackorySlackWeb.Router.Helpers, as: Routes
      import FullStackorySlackWeb.WebhookHelpers

      # The default endpoint for testing
      @endpoint FullStackorySlackWeb.Endpoint
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(FullStackorySlack.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(FullStackorySlack.Repo, {:shared, self()})
    end

    {:ok, conn: Phoenix.ConnTest.build_conn()}
  end
end
