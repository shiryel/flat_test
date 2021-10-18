defmodule FlatTestTest do
  use ExUnit.Case
  doctest FlatTest

  test "flat/2" do
    assert [1, 2, 3, 4, 5, 6, 7, 8, 9] == FlatTest.flat([1, 2, 3, [4, 5, 6], [7, 8, 9]])
    assert [1, 2, 3, 4, 5, 6, 7, 8, 9] == FlatTest.flat([1, 2, 3, [4, 5, 6, [7, 8, 9]]])
  end

  test "format/1" do
    assert FlatTest.format([
             %{text: "One", indent: 0, type: "ordered"},
             %{text: "Two", indent: 0, type: "ordered"},
             %{text: "Alpha", indent: 1, type: "bullet"},
             %{text: "Beta", indent: 1, type: "bullet"},
             %{text: "I", indent: 2, type: "ordered"},
             %{text: "II", indent: 2, type: "ordered"},
             %{text: "Three", indent: 0, type: "ordered"}
           ]) == """
             <ol>
                <li>One</li>
                <li>Two
                  <ul>
                    <li>Alpha</li>
                    <li>Beta
                      <ol>
                        <li>I</li>
                        <li>II</li>
                      </ol>
                    </li>
                  </ul>
                </li>
              <li>Three</li>
            </ol>
           """
  end
end
