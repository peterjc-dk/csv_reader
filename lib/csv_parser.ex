defmodule CsvParser do
  @moduledoc """
  Provides functions for parsing CSV
  """

  @doc """
  Split string, given a seperator, and return list of strings
  ## Examples

      iex> CsvParser.split_csv_line("a,b",",")
      ["a","b"]

  """
  def split_csv_line(line, seperator) do
    String.replace(line,"\n","")
    |> String.split(seperator)
  end

  @doc """
  Filters a list of strings.

  Followed by a Split list of strings, given a seperator.

  Return list of list of strings
  ## Examples

      iex> CsvParser.parse_csv_stream(["a,b","c,b","e,f"],",", "b")
      [["a","b"],["c","b"]]

  """
  def parse_csv_stream(stream, seperator, filter) do
    stream
    |> Stream.filter(&String.contains?(&1, filter))
    |> parse_csv_stream(seperator)
  end

  @doc """
  Split list of strings, given a seperator.

  Return list of list of strings
  ## Examples

      iex> CsvParser.parse_csv_stream(["a,b","c,d","e,f"],",")
      [["a","b"],["c","d"],["e","f"]]

  """
  def parse_csv_stream(stream, seperator) do
    stream
    |> Stream.map(&CsvParser.split_csv_line(&1, seperator))
    |> Enum.to_list
  end

end
