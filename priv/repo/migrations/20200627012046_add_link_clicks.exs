defmodule Dashboard.Repo.Migrations.AddLinkClicks do
  use Ecto.Migration

  def up do
    if Mix.env() == :test do
      execute("create table link_clicks (day date, account_id text, link text, count integer)")
    else
      execute("create materialized view link_clicks as
      select
        date(time) as day,
        metadata ->> 'account_id' as account_id,
        metadata ->> 'click_link' as link,
        count(1) as count
      from
        exlytics.events
      where
        metadata ->> 'click_link' is not null and
        metadata ->> 'account_id' is not null
      group by
        day,
        link,
        account_id
      order by
        day,
        account_id,
        link")
    end

    create(unique_index(:link_clicks, [:account_id, :day, :link]))
    create(index(:link_clicks, [:account_id, :day]))
  end

  def down do
    execute("drop materialized view link_clicks")
  end
end
