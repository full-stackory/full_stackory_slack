defmodule FullStackorySlack.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Start the Ecto repository
      FullStackorySlack.Repo,
      # Start the endpoint when the application starts
      FullStackorySlackWeb.Endpoint,
      FullStackorySlack.PlanSupervisor
      # Starts a worker by calling: FullStackorySlack.Worker.start_link(arg)
      # {FullStackorySlack.Worker, arg},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: FullStackorySlack.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    FullStackorySlackWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
