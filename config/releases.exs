import Config

secret_key_base =
  System.get_env("SECRET_KEY_BASE") ||
    raise """
    environment variable SECRET_KEY_BASE is missing.
    You can generate one by calling: mix phx.gen.secret
    """

google_client_id =
  System.get_env("GOOGLE_CLIENT_ID") ||
    raise """
    environment variable GOOGLE_CLIENT_ID is missing.
    You can generate one by calling: mix phx.gen.secret
    """

google_client_secret =
  System.get_env("GOOGLE_CLIENT_SECRET") ||
    raise """
    environment variable GOOGLE_CLIENT_SECRET is missing.
    You can generate one by calling: mix phx.gen.secret
    """

config :logger, level: :info

config :dashboard, Dashboard.Repo, url: System.get_env("DATABASE_CONNECTION_URL")

config :dashboard, DashboardWeb.Endpoint,
  http: [
    port: String.to_integer(System.get_env("PORT") || "4000"),
    transport_options: [socket_opts: [:inet6]]
  ],
  secret_key_base: secret_key_base,
  url: [host: System.get_env("HOST"), port: 443, scheme: "https"],
  cache_static_manifest: "priv/static/js/manifest.json",
  server: true

config :dashboard, ecto_repos: [Dashboard.Repo]
config :dashboard, google_client_id: google_client_id, google_client_secret: google_client_secret
