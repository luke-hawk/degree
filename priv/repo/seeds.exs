Degree.Repo.delete_all(Degree.User)

%Degree.User{}
|> Degree.User.changeset(%{
  name: "Admin",
  email: "admin@admin.com",
  role: "admin"
  password: "secret",
  password_confirmation: "secret"
})
|> Degree.Repo.insert!()