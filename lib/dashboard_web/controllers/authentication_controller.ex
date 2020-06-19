defmodule DashboardWeb.AuthenticationController do
  @moduledoc false
  use DashboardWeb, :controller

  alias Assent.Strategy.Google
  alias Dashboard.{Repo, User}

  require Logger

  def login(conn, _params) do
    render(conn, "login.html")
  end

  def authorize(conn, _params) do
    config = [
      client_id: Application.get_env(:dashboard, :google_client_id),
      client_secret: Application.get_env(:dashboard, :google_client_secret),
      redirect_uri: Routes.authentication_url(conn, :callback),
      authorization_params: [scope: "openid profile email"]
    ]

    {:ok, %{url: url, session_params: session_params}} = Google.authorize_url(config)

    conn = put_session(conn, :session_params, session_params)

    redirect(conn, external: url)
  end

  def callback(conn, params) do
    config = [
      client_id: Application.get_env(:dashboard, :google_client_id),
      client_secret: Application.get_env(:dashboard, :google_client_secret),
      redirect_uri: Routes.authentication_url(conn, :callback),
      authorization_params: [scope: "openid profile email"]
    ]

    {:ok, %{user: user}} =
      config
      |> Assent.Config.put(:session_params, get_session(conn, :session_params))
      |> Google.callback(params)

    case user do
      %{"email_verified" => true, "email" => email, "sub" => openid} ->
        login_user(conn, email, openid)
        |> redirect(to: "/")

      any ->
        Logger.error(any)
        redirect(conn, to: "/")
    end
  end

  defp login_user(conn, email, openid) do
    case Repo.get_by(User, email: email) do
      %Dashboard.User{id: id} = user ->
        user |> Dashboard.Users.update_openid(openid)
        put_session(conn, :current_user_id, id)

      _ ->
        conn
    end
  end
end
