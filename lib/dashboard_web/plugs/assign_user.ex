defmodule DashboardWeb.Plugs.AssignUser do
  @moduledoc false
  import Plug.Conn
  alias Dashboard.{Repo, User}

  def init(_params) do
  end

  def call(conn, _params) do
    current_user_id = Plug.Conn.get_session(conn, :current_user_id)

    if current_user = current_user_id && Repo.get(User, current_user_id) do
      conn
      |> assign(:current_user, current_user |> Repo.preload(:account))
      |> assign(:user_signed_in?, true)
    else
      conn
      |> assign(:current_user, nil)
      |> assign(:user_signed_in?, false)
    end
  end
end
