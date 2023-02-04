defmodule ExVec.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_vec,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger, :array],
      mod: {ExVec.Application, []}
    ]
  end

  defp deps do
    [
      {:rustler, "~> 0.27.0"}
    ]
  end
end
