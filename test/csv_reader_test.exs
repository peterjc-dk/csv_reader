defmodule CsvReaderTest do
  use ExUnit.Case
  doctest CsvReader

  test "parse args" do
    assert CsvReader.parse_args(["--help"])
    == :help
    assert CsvReader.parse_args([])
    == [:stdin, :no_filter]
    assert CsvReader.parse_args(["file-name"])
    == ["file-name", :no_filter]
    assert CsvReader.parse_args(["--file", "foo"])
    == ["foo", :no_filter]
    assert CsvReader.parse_args(["--file", "foo", "--filter", "bar" ])
    == ["foo", "bar"]
    assert CsvReader.parse_args(["--filter", "foo", "--file", "bar" ])
    == ["bar", "foo"]
    assert CsvReader.parse_args(["--filter", "foo"])
    == [:stdin, "foo"]
    assert CsvReader.parse_args(["name","--filter", "foo"])
    == ["name", "foo"]
    assert CsvReader.parse_args(["--filter", "foo", "name"])
    == ["name", "foo"]
  end
end
