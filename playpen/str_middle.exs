defmodule Challenge do
  import Integer, only: [is_odd: 1, floor_div: 2]
  def get_middle(str), do: _return_middle_char(str, String.length(str))
 
  # Return the middle string as per problem definition
  defp _return_middle_char(str, len) when Integer.is_odd(len), do: String.at(str,Integer.floor_div(len, 2))
  defp _return_middle_char(str, len), do: String.slice(str, Integer.floor_div(len, 2) - 1, 2)
end
