defmodule Play do
  def reduce([], acc, _), do: acc
  def reduce([head | tail], acc, fun), do: reduce(tail, fun.(head, acc), fun)


  # Reversing a list
  def  rev(list), do: rev(list, [])
  defp rev([], acc), do: acc
  defp rev([head | tail], acc), do: rev(tail, [head] ++ acc)
  
end
