# This Kata performs the sum of a list with the following conditions:  
# Add values that are in strings, substract integer values"
defmodule Kata do
  def div_con(list), do: _div_con(list, 0)

  # Recursive computation of value
  def _div_con([], total), do: total
  def _div_con([head | tail], total) when is_integer(head), do: _div_con(tail, total - head)

  def _div_con([head | tail], total) do 
     {val, _} = Integer.parse(head)
     _div_con(tail, total + val)
  end
end
