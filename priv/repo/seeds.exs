Degree.Repo.delete_all(Degree.Accounts.User)

%Degree.Accounts.User{}
|> Degree.User.registration_changeset(%{
  name: "Admin",
  email: "admin@admin.com",
  role: "admin",
  password: "secret",
  password_confirmation: "secret"
})
|> Degree.Repo.insert!()