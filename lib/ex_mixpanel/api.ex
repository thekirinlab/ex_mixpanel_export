defmodule ExMixpanel.Api do
  alias ExMixpanel.{Config}
  require Logger

  @base_url "https://data.mixpanel.com/api/2.0"

  def get(path, query_opts \\ %{}) do
    url = path |> build_url()
    query_opts = Map.merge(
      query_opts,
      %{
        project_id: Config.project_id()
      }
    )
    data = HTTPoison.get(url, headers(), params: query_opts)
    data
    |> handle_response()
  end

  def build_url(path) do
    if String.starts_with?(path, "/") do
      @base_url <> path
    else
      @base_url <> "/" <> path
    end
  end

  def headers() do
    authorization_string = "#{Config.username()}:#{Config.secret()}"
    authorization =  "Basic #{Base.encode64(authorization_string)}"
    [
      "Accept": "text/plain",
      "Authorization": authorization,
    ]
  end

  defp handle_response({:ok, %HTTPoison.Response{body: body, status_code: code}})
       when code in 200..299 do
    {:ok, Poison.decode!(body)}
  end

  defp handle_response({:error, %HTTPoison.Error{id: nil, reason: :timeout}}),
    do: {:error, reason: :timeout}

  defp handle_response({:error, %HTTPoison.Error{id: nil, reason: :econnrefused}}),
    do: {:error, reason: :econnrefused}

  defp handle_response({:error, %HTTPoison.Response{body: body, status_code: _}}) do
    Logger.error(inspect(body))
    {:error, Poison.decode(body)}
  end
end
