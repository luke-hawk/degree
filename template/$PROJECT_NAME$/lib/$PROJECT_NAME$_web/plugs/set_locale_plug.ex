defmodule <%= @project_name_camel_case %>Web.Plugs.SetLocale do
  import Plug.Conn
  import Phoenix.Controller 

  @locales ["en", "de"]
  @fallback_locale "en"
  
  def init(_options), do: nil 
  def call(conn, _options) do
  	if Enum.any?(conn.path_info, fn x -> x in  @locales  end) do
  		conn
  	else
  		conn
  		|> get_request_locale
  		|> redirect_to_locale(conn)
  	end
  end

  defp get_request_locale(conn) do
  	conn
  	|> get_req_header("accept-language")
  	|> tokenize
  	|> request_locale
  end

  @language_separator ","
  defp tokenize(accept_language) do
    accept_language
    |> List.first
    |> String.downcase
    |> String.replace(" ", "")
    |> String.split(@language_separator)
    |> Enum.reject(&is_nil/1)
    |> Enum.reject(&String.starts_with?(&1, "*"))
    |> Enum.map(&token_tuple/1)
  end

  @quality_separator ";q="
  @default_quality 1.0
  @low_quality 0.2
  defp token_tuple(language) do
    case String.split(language, @quality_separator) do
      [language, quality] ->
        {parse_quality(quality), language}

      [language] ->
        {@default_quality, language}

      [language | _rest] ->
        {@low_quality, language}
    end
  end

  defp parse_quality(quality_string) do
    case Float.parse(quality_string) do
      :error -> @low_quality
      {quality, _} -> quality
    end
  end

  defp request_locale(token_tuple) do
  	token_tuple
  	|> List.first
  	|> elem(1)
  	|> String.split("-")
  	|> List.first
  end

  defp redirect_to_locale(request_locale, conn) do
  	path = rewrite_path(conn, request_locale)

  	conn
  	  |> redirect(to: path)
  	  |> halt
  end

  defp rewrite_path(%{request_path: request_path} = conn, request_locale) do
  	if Enum.member?(@locales, request_locale) do
  		"/#{request_locale}#{request_path}"
  	else
  		"#{@fallback_locale}#{request_path}"
  	end
  end
end