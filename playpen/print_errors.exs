defmodule Printererror do
  def printer_error(s) do
     errors = to_charlist(s)
              |> Enum.reduce(0, fn x, acc -> acc + error?(x) end)  
     "#{errors}/#{String.length(s)}"
  end

  def error?(char), do: if char > ?m, do: 1, else: 0
end
