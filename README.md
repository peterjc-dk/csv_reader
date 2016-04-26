# csv_reader
This is a small demo command line application written in Elixir. It reads in a CSV file and shows it as a ASCII table on STDOUT.
 

## Install
```sh
$ git clone https://github.com/peterjc-dk/csv_reader.git
$ cd csv_reader
$ mix deps.get 
$ mix escript.build
```
Last step create a binary called csv_reader, this you can place where you prefer to have you bins.  
## Use 
```sh

$ csv_reader resources/hair_eye_color.csv --filter green
+-------+-------+--------+----+
| black | green | male   | 3  |
| brown | green | male   | 15 |
| red   | green | male   | 7  |
| blond | green | male   | 8  |
| black | green | female | 2  |
| brown | green | female | 14 |
| red   | green | female | 7  |
| blond | green | female | 8  |
+-------+-------+--------+----+
```
For a full list of options execute: 
```sh
$ csv_reader --help

```
# Under the hood

## Mix file 

```elixir
  def project do
    [app: :csv_reader,
     version: "0.0.2",
     elixir: "~> 1.2",
     escript: [main_module: CsvReader],
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end
  
  def application do
    [applications: [:logger, :table_rex]]
  end

  defp deps do
    [{:table_rex, "~> 0.8.0"}]
  end
```
## Parsing Command line options (simplified)
```elixir
defmodule CsvReader do
   def main(args) do
     args |> parse_args |> do_process
   end
 
   def parse_args(args) do
     options = OptionParser.parse(args)
 
     case options do
       {[file: file], _, _} -> [file]
       {[help: true], _, _} -> :help
                          _ -> :help
 
     end
   end
 
   def do_process([file]) do
     require TableRex
     File.stream!(file)
     |> CsvParser.parse_csv_stream(",")
     |> TableRex.quick_render!
     |> IO.puts
   end
 
   def do_process(:help) do
     IO.puts """
     Usage:
     ./csv_reader --file [csv file]
 
     Options:
     --help  Show this help message.
 
     Description:
     Reads a CSV file and prints it as a ASCII table.
   """
 
     System.halt(0)
   end
 end  
```  
## Parsing The CSV  (Simplified)
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
## Test CsvParser
```elixir
defmodule CsvParserTest do
  use ExUnit.Case
  doctest CsvParser

  test "line splitter" do
    assert ["a","b"] == CsvParser.split_csv_line("a,b",",")
    assert ["aa","bb","cc"] == CsvParser.split_csv_line("aa;bb;cc",";")
  end

  test "stream parser" do
    assert [["a","b"],["c","d"]]
    == CsvParser.parse_csv_stream(["a,b","c,d"],",")
  end
end
```  

If [available in Hex](https://hex.pm/docs/publish), The package can be installed as:

  1. Add csvReader to your list of dependencies in `mix.exs`:
```Elixir
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
