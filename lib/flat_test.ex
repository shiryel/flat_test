defmodule FlatTest do
  def flat(_input, _result \\ [])

  def flat([hd | tl], result) do
    flat(tl, result ++ flat(hd))
  end

  def flat([], result) do
    result
  end

  def flat(hd, result) do
    [hd | result]
  end

  ###

  def format(list_format) do
    """
      <ol>
        #{Enum.reduce(list_format, {0, []}, &do_format/2)}
      </ol>
    """
  end

  defp do_format(line, {last_i, history}) do
    type_before? = Enum.any?(history, &(&1.type == line.type))

    result =
      if type_before? do
        "<li>#{line.text}</li>"
      else
        """
          #{get_type(line.type)}
          <li>#{line.text}</li>
        """
      end

    {result, {line.indent, [line | history]}}
  end

  defp get_type("ordered"), do: "<ol>"
  defp get_type("bullet"), do: "<ul>"

  defp get_type_end("ordered"), do: "</ol>"
  defp get_type_end("bullet"), do: "</ul>"
end
