defmodule Solution do
  def nb_year(p0, percent, aug, p) do
      _nb_year(p0, percent, aug, p, 0)        
  end

  def _nb_year(p0, _, _, p, num) when p <= p0, do: num
  def _nb_year(p0, percent, aug, p, num) do
     _nb_year(trunc(p0 + (p0 * percent / 100) + aug), percent, aug, p, num + 1)
  end
  
end
