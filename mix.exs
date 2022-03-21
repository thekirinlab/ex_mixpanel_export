defmodule ExMixpanelExport.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_mixpanel_export,
      version: "1.0.1",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      elixirc_paths: elixirc_paths(Mix.env()),
      description: description(),
      package: package(),
      deps: deps()
    ]
  end

  def description do
    "Library for consuming Mixpanel export API. Support exporting to CSV."
  end

  defp package do
    [
      name: :ex_mixpanel_export,
      files: ["lib", "mix.exs", "README*"],
      maintainers: ["TheKirinLab"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/thekirinlab/ex_mixpanel_export"}
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
      {:poison, "~> 3.1"},
      {:nimble_csv, "~> 0.6"},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end

  defp elixirc_paths(:test), do: elixirc_paths() ++ ["test/support"]
  defp elixirc_paths(_), do: elixirc_paths()
  defp elixirc_paths(), do: ["lib"]
end
