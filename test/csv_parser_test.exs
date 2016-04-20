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
