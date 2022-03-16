defmodule ExMixpanel.Config do
  @moduledoc """
  Utility that handles interaction with the application's configuration
  """

  @doc """
  In config.exs, use a string, a function or a tuple:
      config :ex_mixpanel, username: System.get_env("MIXPANEL_EXPORT_USERNAME")

  or:
      config :ex_mixpanel, username: {:system, "MIXPANEL_EXPORT_USERNAME"}

  or:
      config :ex_mixpanel, username: {MyApp.Config, :username, []}
  """
  def username do
    resolve(:username)
  end

  @doc """
  In config.exs, use a string, a function or a tuple:
      config :ex_mixpanel, secret: System.get_env("MIXPANEL_EXPORT_SECRET")

  or:
      config :ex_mixpanel, secret: {:system, "MIXPANEL_EXPORT_SECRET"}

  or:
      config :ex_mixpanel, secret: {MyApp.Config, :secret, []}
  """
  def secret do
    resolve(:secret)
  end

  @doc """
  In config.exs, use a string, a function or a tuple:
      config :ex_mixpanel, project_id: System.get_env("MIXPANEL_EXPORT_PROJECT_ID")

  or:
      config :ex_mixpanel, project_id: {:system, "MIXPANEL_EXPORT_PROJECT_ID"}

  or:
      config :ex_mixpanel, project_id: {MyApp.Config, :project_id, []}
  """
  def project_id do
    resolve(:project_id)
  end

  @doc """
  Resolves the given key from the application's configuration returning the
  wrapped expanded value. If the value was a function it get's evaluated, if
  the value is a touple of three elements it gets applied.
  """
  @spec resolve(atom, any) :: any
  def resolve(key, default \\ nil)

  def resolve(key, default) when is_atom(key) do
    Application.get_env(:ex_mixpanel, key, default)
    |> expand_value()
  end

  def resolve(key, _) do
    raise(
      ArgumentError,
      message: "#{__MODULE__} expected key '#{key}' to be an atom"
    )
  end

  defp expand_value({:system, env})
       when is_binary(env) do
    System.get_env(env)
  end

  defp expand_value({module, function, args})
       when is_atom(function) and is_list(args) do
    apply(module, function, args)
  end

  defp expand_value(value) when is_function(value) do
    value.()
  end

  defp expand_value(value), do: value
end
