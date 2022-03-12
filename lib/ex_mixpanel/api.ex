defmodule ExMixpanel.Api do
  require Logger

  @exporter_username Application.get_env(:ex_mixpanel_export_username, :username)
  @exporter_password Application.get_env(:ex_mixpanel_export_password, :secret)
  @exporter_project_id Application.get_env(:ex_mixpanel_export_password, :project_id)
  @base_url "https://data.mixpanel.com/api/2.0/export"

  def get(path, query_opts \\ %{}) do
    url = path |> build_url()
    query_opts = Map.merge(
      query_opts,
      %{
        project_id: @exporter_project_id
      }
    )

    HTTPoison.get(url, headers(), params: query_opts)
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
    authorization =  "Basic #{Base.encode64("#{@exporter_username}:#{@exporter_password}}")}}"
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

  defp handle_response({:error, %HTTPoison.Response{body: body, status_code: _}}) do
    Logger.error(inspect(body))
    {:error, Poison.decode(body)}
  end
end
