defmodule Dashboard.Account do
  @moduledoc false

  use Ecto.Schema
  # import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "accounts" do
    timestamps()
  end

  def changeset(account, _params \\ %{}) do
    account
  end
end
