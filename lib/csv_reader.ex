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
