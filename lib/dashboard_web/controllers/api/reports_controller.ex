defmodule DashboardWeb.Api.ReportsController do
  use DashboardWeb, :controller
  plug DashboardWeb.Plugs.RequireUser

  alias Dashboard.Reports

  def show(conn, %{"type" => type}) do
    render(conn, "show.json", %{data: Reports.report(conn.assigns.current_user, type)})
  end
end
