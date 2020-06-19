use Mix.Config

config :dashboard, DashboardWeb.Endpoint,
  http: [port: 4002],
  server: false

config :logger, level: :debug

config :dashboard, Dashboard.Repo,
  url: System.get_env("DATABASE_CONNECTION_URL", "ecto://postgres@localhost:5432/exlytics_test"),
  pool: Ecto.Adapters.SQL.Sandbox
