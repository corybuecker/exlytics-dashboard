use Mix.Config

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :dashboard, ecto_repos: [Dashboard.Repo]
config :dashboard, DashboardWeb.Endpoint, force_ssl: [rewrite_on: [:x_forwarded_proto]]

config :phoenix, :json_library, Jason

import_config "#{Mix.env()}.exs"
