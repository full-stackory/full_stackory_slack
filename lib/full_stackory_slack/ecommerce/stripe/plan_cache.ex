defmodule FullStackorySlack.PlanCache do
  @moduledoc """
  GenServer utilizing `:ets` to store plan information from stripe. Loads data
  upon initialization from stripe and handles update via `handle_call` to the
  ets store.
  """
  use GenServer

  @table_name :plan_cache_table
  @stripe Application.get_env(:full_stackory_slack, :stripe_client, Stripe)

  @impl true
  def init(opts) do
    [
      {:ets_table_name, ets_table_name},
      {:log_limit, log_limit}
    ] = opts

    :ets.new(ets_table_name, [:named_table, :set, :private])

    schedule_stripe_request()

    {:ok, %{log_limit: log_limit, ets_table_name: ets_table_name}}
  end

  def start_link(opts \\ []) do
    GenServer.start_link(
      __MODULE__,
      [
        {:ets_table_name, @table_name},
        {:log_limit, 10}
      ],
      opts
    )
  end

  @doc """
  Public API function that gets all items in the `:plan_cache_table` via
  synchronous call statement.
  """
  @spec get_collection() :: list
  def get_collection() do
    GenServer.call(__MODULE__, :get_collection)
  end

  @impl true
  def handle_call(:get_collection, _from, state) do
    {:reply, :ets.tab2list(@table_name), state}
  end

  @impl true
  def handle_info(:work, state) do
    plans =
      %{active: true}
      |> @stripe.Plan.list(expand: ["data.product"])
      |> elem(1)
      |> Map.get(:data, :data)
      |> Enum.map(fn plan ->
        {plan.id, plan}
      end)

    :ets.insert(@table_name, plans)

    {:noreply, state}
  end

  defp schedule_stripe_request() do
    Process.send_after(self(), :work, 10)
  end
end
