defmodule FullStackorySlack.PlanSupervisor do
  @moduledoc """
  Supervisor that monitors and handles our `PlanCache` GenServer.
  """
  @moduledoc since: "0.0.1"

  use Supervisor
  alias FullStackorySlack.PlanCache

  def start_link(_opts) do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    children = [
      worker(PlanCache, [[name: FullStackorySlack.PlanCache]])
    ]

    supervise(children, strategy: :one_for_one)
  end
end
