defmodule DashboardWeb.ReportsController do
  @moduledoc false
  use DashboardWeb, :controller
  plug DashboardWeb.Plugs.RequireUser

  def index(conn, _params) do
    render(conn, "index.html", user: inspect(conn.assigns.current_user))
  end
end
