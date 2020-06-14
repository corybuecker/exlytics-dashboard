defmodule Dashboard.Reports do
  @moduledoc false
  alias Dashboard.User
  alias Dashboard.Repo
  import Ecto.Query

  def report(%User{} = user, type) do
    case type do
      "page_views" -> Repo.all(page_views_by_account(user.account_id), prefix: "reports")
      "link_clicks" -> Repo.all(link_clicks_by_account(user.account_id), prefix: "reports")
    end
  end

  defp page_views_by_account(account_id) do
    today = Date.utc_today()
    ninety_days_ago = Date.add(today, -90)

    from r in "page_views",
      where:
        r.account_id == ^account_id and r.day <= ^today and
          r.day >= ^ninety_days_ago,
      select: %{date: r.day, count: sum(r.count)},
      group_by: r.day
  end

  defp link_clicks_by_account(account_id) do
    today = Date.utc_today()
    ninety_days_ago = Date.add(today, -90)

    from r in "link_clicks",
      where:
        r.account_id == ^account_id and r.day <= ^today and
          r.day >= ^ninety_days_ago,
      select: %{date: r.day, count: sum(r.count)},
      group_by: r.day
  end
end
