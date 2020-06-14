defmodule DashboardWeb.Api.ReportsView do
  use DashboardWeb, :view

  def render("show.json", %{data: data}) do
    %{
      data:
        data
        |> Enum.map(fn %{date: date, count: count} ->
          %{date: date, count: count |> Decimal.to_integer()}
        end)
    }
  end
end
