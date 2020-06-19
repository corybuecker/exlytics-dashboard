defmodule Dashboard.PageView do
  @moduledoc false

  use Ecto.Schema

  @primary_key false
  schema "page_views" do
    field(:day, :date)
    field(:account_id, :string)
    field(:page, :string)
    field(:count, :integer)
  end
end
