defmodule StdinReader do
  @moduledoc """
  Provides functions for reading from STDIN.
  """

  @doc """
  Read asyncronic from STDIN, with a timeout of 1000
  """
  def read_async do
    task = Task.async(fn -> StdinReader.read end)
    Task.await(task, 1000)
  end

  @doc """
  Read from STDIN
  """
  def read do
    read([])
  end

  defp read(accumulator) do
    case IO.read(:stdio, :line) do
      :eof -> Enum.reverse(accumulator)
      {:error, reason} -> IO.puts "Error: #{reason}"
      data ->
        read([data|accumulator])
    end
  end
end
