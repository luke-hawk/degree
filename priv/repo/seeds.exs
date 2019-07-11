Degree.Repo.delete_all(Degree.Coherence.User)

%Degree.Coherence.User{}
|> Degree.Coherence.User.changeset(%{
  name: "Admin",
  email: "admin@admin.com",
  role: "admin"
  password: "secret",
  password_confirmation: "secret"
})
|> Degree.Repo.insert!()