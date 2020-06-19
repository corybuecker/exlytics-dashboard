defmodule Dashboard.Repo.Migrations.AddPageViews do
  use Ecto.Migration

  def up do
    if Mix.env() == :test do
      execute("create table page_views (day date, account_id text, page text, count integer)")
    else
      execute("create materialized view page_views as
        select
          date(time) as day,
          metadata ->> 'account_id' as account_id,
          metadata ->> 'page' as page,
          count(1) as count
        from
          exlytics.events
        where
          metadata ->> 'page' is not null and
          metadata ->> 'account_id' is not null
        group by
          day,
          page,
          account_id
        order by
          day,
          account_id,
          page")
    end

    create(unique_index(:page_views, [:account_id, :day, :page]))
    create(index(:page_views, [:account_id, :day]))
  end

  def down do
    execute("drop materialized view page_views")
  end
end
