defmodule Stytch.MixProject do
  use Mix.Project

  def project do
    [
      app: :stytch,
      version: "0.1.0",
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      deps: deps(),

      # Docs
      docs: docs(),
      name: "Stytch Elixir SDK",
      source_url: "https://github.com/togethercomputer/stytch-elixir",
      homepage_url: "https://github.com/togethercomputer/stytch-elixir",

      # Dialyzer
      dialyzer: [
        # Put the project-level PLT in the priv/ directory (instead of the default _build/ location)
        plt_file: {:no_warn, "priv/plts/project.plt"},
        plt_add_apps: [:ex_unit, :mix]
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.4", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.38", only: [:dev], runtime: false},
      {:jose, "~> 1.11"},
      {:oapi_generator, github: "aj-foster/open-api-generator", branch: "main"},
      {:req, "~> 0.5"},
      {:req_telemetry, "~> 0.1"}
    ]
  end

  defp docs do
    [
      main: "readme",
      extras: [
        "README.md": [title: "Introduction"],
        "CODE_OF_CONDUCT.md": [title: "Code of Conduct"],
        "CONTRIBUTING.md": [title: "Contributing"],
        LICENSE: [title: "License"]
      ],
      formatters: ["html"],
      source_ref: "main"
    ]
  end
end
