Degree.Repo.delete_all(Degree.Coherence.User)

%Degree.Coherence.User{}
|> Degree.Coherence.User.changeset(%{
  name: "Test User",
  email: "testuser@example.com",
  password: "secret",
  password_confirmation: "secret"
})
|> Degree.Repo.insert!()