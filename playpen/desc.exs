defmodule Kata do
  def test(n) do
    _num_to_list(n) 
    |> Enum.sort(&>=/2)
    |> Enum.reduce(0, fn x, acc -> acc * 10 + x end) 
  end

  # Transforma an integer to a list of integer ditits
  defp _num_to_list(num), do: _num_to_list(num, [])
  defp _num_to_list(0, list), do: list
  defp _num_to_list(num, list), do: _num_to_list(Integer.floor_div(num,10), [ Integer.mod(num, 10) | list ])
end



