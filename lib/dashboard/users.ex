defmodule Dashboard.Users do
  @moduledoc false
  alias Dashboard.User
  alias Dashboard.Repo
  import Ecto.Query

  def update_openid(%User{} = user, openid) do
    {:ok, user} = User.changeset(user, %{openid: openid}) |> Repo.update()
    user
  end
end
