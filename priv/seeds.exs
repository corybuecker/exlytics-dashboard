alias Dashboard.{User, Account, Repo}

%Account{id: account_id} = %Account{} |> Repo.insert!()

%User{email: "#{Ecto.UUID.generate()}@exlytics.dev", account_id: account_id}
|> Repo.insert!()
