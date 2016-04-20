# csv_reader

**TODO: Add description**

## Installation
```elixir
defmodule CsvParser do

  def split_csv_line(line, seperator) do
    String.replace(line,"\n","")
    |> String.split(seperator)
  end

  def parse_csv_stream(stream, seperator) do
    stream
    |> Stream.map(&CsvParser.split_csv_line(&1,seperator))
    |> Enum.to_list
  end
end
```
If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add csvReader to your list of dependencies in `mix.exs`:

        def deps do
          [{:csvReader, "~> 0.0.1"}]
        end

  2. Ensure csvReader is started before your application:

        def application do
          [applications: [:csvReader]]
        end

