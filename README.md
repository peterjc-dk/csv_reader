# A sip of Elixir
As part of a presentation about Elixir given at a Meetup in Copenhagen, this small command line app was used as a demo.

## The Presentation
A general overview of interesting features was  presented in a Prezi presentation available here [A sip of Elixir](http://prezi.com/t8zxmnn8xazc/?utm_campaign=share&utm_medium=copy)  
 
# csv_reader

## Download

## Compile

## Use 



## Examble
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
If [available in Hex](https://hex.pm/docs/publish), The package can be installed as:

  1. Add csvReader to your list of dependencies in `mix.exs`:
```elixir
  def deps do
    [{:csvReader, "~> 0.0.1"}]
  end
```
  2. Ensure csvReader is started before your application:
```elixir
  def application do
    [applications: [:csvReader]]
  end
```
