defmodule Dashboard.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create(table(:users, primary_key: false)) do
      add(:id, :uuid, primary_key: true, default: fragment("uuid_generate_v4()"))

      add(:email, :string, null: false)
      add(:openid, :string, null: true)
      add(:account_id, references("accounts", type: :uuid, on_delete: :delete_all), null: false)

      timestamps(default: fragment("now()"))
    end

    create(unique_index(:users, :email))
    create(unique_index(:users, :openid))
  end
end
