defmodule Dashboard.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create(table(:accounts, primary_key: false)) do
      add(:id, :uuid, primary_key: true, default: fragment("uuid_generate_v4()"))

      timestamps(default: fragment("now()"))
    end
  end
end
