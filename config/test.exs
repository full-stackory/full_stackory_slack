use Mix.Config

# Configure your database
config :full_stackory_slack, FullStackorySlack.Repo,
  database: "full_stackory_slack_test",
  hostname: "localhost",
  show_sensitive_data_on_connection_error: true,
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :full_stackory_slack, FullStackorySlackWeb.Endpoint,
  http: [port: 4002],
  server: false

config :full_stackory_slack,
  stripe_client: Fakes.Stripe,
  stripe_http_secret: "secret"

# Print only warnings and errors during test
config :logger, level: :warn

if System.get_env("GITHUB_ACTIONS") do
  config :full_stackory_slack, FullStackorySlack.Repo,
    username: "postgres",
    password: "postgres"
end
