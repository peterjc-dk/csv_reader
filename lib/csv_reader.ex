defmodule CsvReader do
  @moduledoc """
  Provides Main CSV Reader methods.
  """

  @doc """
  main function
  """
  def main(args) do
    try do
      args |> parse_args |> do_process
    rescue
      RuntimeError -> do_process(:exit)
    catch
      :exit, _ -> do_process(:exit)
    end
  end

  def parse_args(args) do
    options = OptionParser.parse(
      args, aliases: [h: :help, f: :file])
    case options do
      {[file: file], _, _} -> [file, :no_filter]
      {[file: file, filter: filter], _, _} -> [file, filter]
      {[filter: filter, file: file], _, _} -> [file, filter]
      {[filter: filter], [file], _} -> [file, filter]
      {[filter: filter], _, _} -> [:stdin, filter]
      {[help: true], _, _} -> :help
      {_, [file], _} -> [file, :no_filter]
                   _ -> [:stdin, :no_filter]

    end
  end

  def do_process([:stdin, filter]) do
    require StdinReader
    StdinReader.read_async
    |> to_csv_to_table(",", filter)
  end

  def do_process([file, filter]) do
    File.stream!(file)
    |> to_csv_to_table(",", filter)
  end

  def do_process(:exit) do
    IO.puts "Error executing csv_reader"
    do_process(:help)
  end

  def do_process(:help) do
    IO.puts """
    Usage:
      csv_reader < [file]
      csv_reader [file]
      csv_reader --file [file]
      csv_reader --file [file] --filter [filter]

    Options:
    --help  Show this help message.
    --file  [file] CSV File to read
    --filter  [filter] Filter lines in CSV file using [filter]

    Description:
    Reads a CSV file and prints it as a ASCII table.

    Is a filter used, only lines matching this will be shown.

    Used without a filter all lines are shown.
  """

    System.halt(0)
  end

  def to_csv_to_table(stream, seperator, filter) do
    require TableRex
    csv =
      cond do
      filter == :no_filter or  filter == :true ->
        CsvParser.parse_csv_stream(stream, seperator)
      true ->
        CsvParser.parse_csv_stream(stream, seperator, filter)
      end
    TableRex.quick_render!(csv) |> IO.puts
  end
end
