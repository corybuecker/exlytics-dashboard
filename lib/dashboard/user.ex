defmodule Dashboard.User do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "users" do
    field(:email, :string)
    field(:openid, :string)

    belongs_to(:account, Dashboard.Account, type: Ecto.UUID)

    timestamps()
  end

  def changeset(user, params \\ %{}) do
    user
    |> cast(params, [:email, :openid])
    |> validate_required([:email])
    |> validate_format(:email, ~r/@/)
    |> cast_assoc(:account)
    |> unique_constraint(:email)
    |> unique_constraint(:openid)
  end
end
