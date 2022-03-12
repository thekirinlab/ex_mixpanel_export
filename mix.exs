defmodule ExMixpanel.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_mixpanel,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps()
    ]
  end

  def description do
    "Library for consuming Mixpanel export API"
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*"],
      maintainers: ["Nguyễn Giang Nam"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/ngnclht1102/ex_mixpanel"}
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 1.0"},
      {:timex, "~> 3.1"},
      {:poison, "~> 3.1"}
    ]
  end
end
