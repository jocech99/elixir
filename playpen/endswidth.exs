defmodule EndsWith do
  def solution(str, ending), do: _endswith(str, ending)

  defp _endswith(str, ending) when str == ending, do: true

  defp _endswith(<<_::utf8, tail::binary>>, ending) do
    cond do
      String.length(tail) < String.length(ending) -> false
      ending == tail -> true
      true -> _endswith(tail, ending)
    end
  end
end
