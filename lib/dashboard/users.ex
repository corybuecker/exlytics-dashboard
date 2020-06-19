defmodule Dashboard.Users do
  @moduledoc false

  alias Dashboard.{Repo, User}

  def update_openid(%User{} = user, openid) do
    {:ok, user} = User.changeset(user, %{openid: openid}) |> Repo.update()
    user
  end
end
