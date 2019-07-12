defmodule DegreeWeb.SessionController do
  use DegreeWeb, :controller

  def new(conn, _) do
    render(conn, "new.html")
  end

  def create(conn, %{"session" => %{"email" => user, "password" => password}}) do
    case Degree.Auth.authenticate_user(user, password) do
      {:ok, user} ->
        conn
        |> Degree.Auth.login(user)
        |> put_flash(:info, "Welcome back!")
        |> redirect(to: Routes.admin_path(conn, :index))

      {:error, _reason} ->
        conn
        |> put_flash(:error, "Invalid username/password combination")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> Degree.Auth.logout()
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
