defmodule FullStackorySlack.Repo do
  use Ecto.Repo,
    otp_app: :full_stackory_slack,
    adapter: Ecto.Adapters.Postgres
end
