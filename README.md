# ExVec

re-creating rust's `vec!` macro in elixir, [read about it here!](www.hailelagi.com/writing/legos/)

## Example
```elixir
defmodule MyApp.DoStuff do
  use ExVec, implementation: :rust

  def len do
    vec!(1..5) |> Enum.count()
  end

  def map_by_2 do
    vec!(1..5) |> Enum.map(fn n -> n * 2 end)
  end
end
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ex_vec` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_vec, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/ex_vec>.
