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
    |> redirect(to: Routes.web_page_path(conn, :index))
  end

  def logged_in?(conn) do
    case verify_session(conn) do
      {:ok, _success} ->
        true
      {:error, _error} ->
        false
    end
  end

  defp verify_session(conn) do
    conn
    |> get_session(:guardian_admin_token)
    |> Degree.Auth.Guardian.decode_and_verify
  end
end
