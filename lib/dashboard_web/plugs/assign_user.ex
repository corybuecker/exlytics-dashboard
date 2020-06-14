defmodule DashboardWeb.Plugs.AssignUser do
  import Plug.Conn
  alias Dashboard.{User, Repo}

  def init(_params) do
  end

  def call(conn, _params) do
    current_user_id = Plug.Conn.get_session(conn, :current_user_id)

    cond do
      current_user = current_user_id && Repo.get(User, current_user_id) ->
        conn
        |> assign(:current_user, current_user |> Repo.preload(:account))
        |> assign(:user_signed_in?, true)

      true ->
        conn
        |> assign(:current_user, nil)
        |> assign(:user_signed_in?, false)
    end
  end
end
