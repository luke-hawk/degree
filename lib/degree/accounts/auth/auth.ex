defmodule Degree.Auth do
  @moduledoc false

  require Ecto.Query

  import Plug.Conn

  alias Degree.Auth.Guardian
  alias Degree.Accounts.User
  alias Degree.Repo

  def authenticate_user(email, given_password) do
    case Repo.get_by(User, email: email) do
      nil ->
        {:error, :not_found}
      user ->
        if Argon2.check_pass(given_password, user.password_hash) do
          {:ok, user}
        else
          {:error, :unauthorized}
        end
    end
  end

  def login(conn, user) do
    conn
    |> Guardian.Plug.sign_in(user, key: :admin)
    |> assign(:current_user, user)
    |> put_user_token(user)
  end

  def logout(conn) do
    conn
    |> Guardian.Plug.sign_out()
  end

  def load_current_user(conn, _) do
    conn
    |> assign(:current_user, Guardian.Plug.current_resource(conn))
    |> put_user_token(Guardian.Plug.current_resource(conn))
  end

  defp put_user_token(conn, user) do
    token = Phoenix.Token.sign(conn, "user socket", user.id)

    conn
    |> assign(:user_token, token)
  end
end
