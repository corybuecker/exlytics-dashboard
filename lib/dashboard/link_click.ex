defmodule Dashboard.LinkClick do
  @moduledoc false

  use Ecto.Schema

  @primary_key false
  schema "link_clicks" do
    field(:day, :date)
    field(:account_id, :string)
    field(:link, :string)
    field(:count, :integer)
  end
end
