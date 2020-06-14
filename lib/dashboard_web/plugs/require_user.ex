defmodule DashboardWeb.Plugs.RequireUser do
  import Plug.Conn
  alias DashboardWeb.Router.Helpers
  import Phoenix.Controller

  def init(_params) do
  end

  def call(conn, _params) do
    if conn.assigns.user_signed_in? do
      conn
    else
      conn
      |> put_flash(:error, "You need to sign in or sign up before continuing.")
      |> redirect(to: Helpers.authentication_path(conn, :login))
      |> halt()
    end
  end
end
