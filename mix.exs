defmodule Stytch.MixProject do
  use Mix.Project

  def project do
    [
      app: :stytch,
      version: "0.1.0",
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:jose, "~> 1.11"},
      {:oapi_generator, github: "aj-foster/open-api-generator", branch: "main"},
      {:req, "~> 0.5"},
      {:req_telemetry, "~> 0.1"}
    ]
  end
end
