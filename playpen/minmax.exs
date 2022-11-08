defmodule Blah do
  import Kernel, except: [min: 2, max: 1]

  def max([head | tail]), do: _max(tail, head)
  defp _max([], max_val), do: max_val
  defp _max([head | tail], max_val) when head > max_val, do: _max(tail, head)
  defp _max([_ | tail], max_val), do: _max(tail, max_val)

  def min([head | tail]), do: _min(tail, head)
  defp _min([], min_val), do: min_val
  defp _min([head | tail], min_val) when head < min_val, do: _min(tail, head)
  defp _min([_ | tail], min_val), do: _min(tail, min_val)
end
