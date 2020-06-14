defmodule DashboardWeb.HealthcheckController do
  @moduledoc false
  use DashboardWeb, :controller
  alias Ecto.Adapters.SQL
  alias Dashboard.Repo

  def index(conn, _params) do
    case SQL.query(Repo, "select 1", [], [{:log, false}]) do
      {:ok, _results} ->
        conn
        |> Plug.Conn.put_resp_header("content-type", "application/json")
        |> send_resp(200, "{\"database\":true}")

      _ ->
        send_resp(conn, 500, "")
    end
  end
end
