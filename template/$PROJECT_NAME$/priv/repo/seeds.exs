<%= @project_name_camel_case %>.Repo.delete_all(<%= @project_name_camel_case %>.Accounts.User)

%<%= @project_name_camel_case %>.Accounts.User{}
|> <%= @project_name_camel_case %>.Accounts.User.registration_changeset(%{
  name: "Admin",
  email: "admin@admin.com",
  role: "admin",
  password: "secret",
  password_confirmation: "secret"
})
|> <%= @project_name_camel_case %>.Repo.insert!()