defmodule DashboardWeb.Router do
  use DashboardWeb, :router

  pipeline :healthcheck do
  end

  pipeline :browser do
    plug Plug.SSL, rewrite_on: [:x_forwarded_proto]
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {DashboardWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers

    plug DashboardWeb.Plugs.AssignUser
  end

  pipeline :api do
    plug Plug.SSL, rewrite_on: [:x_forwarded_proto]
    plug :accepts, ["json"]
    plug :fetch_session
    plug :protect_from_forgery

    plug DashboardWeb.Plugs.AssignUser
  end

  scope "/healthcheck", DashboardWeb do
    get "/", HealthcheckController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", DashboardWeb do
    pipe_through :api

    resources "/reports", Api.ReportsController, only: [:show], param: "type"
  end

  scope "/", DashboardWeb do
    pipe_through :browser

    get "/", ReportsController, :index

    get "/authentication/login", AuthenticationController, :login
    get "/authentication/authorize", AuthenticationController, :authorize
    get "/authentication/callback", AuthenticationController, :callback
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: DashboardWeb.Telemetry
    end
  end
end
