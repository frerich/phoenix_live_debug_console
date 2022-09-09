defmodule PhoenixLiveDebugConsole.MixProject do
  use Mix.Project

  def project do
    [
      app: :phoenix_live_debug_console,
      description: description(),
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),
      source_url: github_url(),
      name: "Phoenix LiveDebugConsole",
      docs: [
        extras: ["README.md", "LICENSE.md"],
        main: "readme",
        api_reference: false
      ],
      package: package()
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
      {:underthehood, "~> 0.1"},
      {:phoenix_live_view, "~> 0.17"},
      {:jason, "~> 1.0"},
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:esbuild, "~> 0.4", runtime: Mix.env() == :dev},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end

  defp aliases do
    [
      "assets.deploy": ["esbuild default --minify"]
    ]
  end

  defp description do
    "An extension to the Phoenix error view, adding a fully-functional IEx terminal to it."
  end

  defp github_url do
    "https://github.com/frerich/phoenix_live_debug_console"
  end

  defp package do
    [
      files: ~w(dist lib .formatter.exs mix.exs README.md LICENSE.md),
      licenses: ["MIT"],
      links: %{"GitHub" => github_url()}
    ]
  end
end
