defmodule MyRange do
  @doc"""
  Generate a range with a step
  """
  def range(start, end_index, step \\ 1)
  def range(start, end_index, _) when start > end_index, do: []
  def range(start, end_index, step), do: [ start ] ++ range(start + step, end_index, step)


  @doc"""
  Remove from a list items that belong to another list
  """
  def remove([], _), do: []
  def remove([head | tail], list_to_remove) do
    case head in list_to_remove do 
      true ->  remove(tail, list_to_remove)
      false -> [head] ++ remove(tail, list_to_remove)
    end
  end


  @doc"""
  Implement the Erathostene sieve to find integers smaller thean a number
  """
  def sieve([], _, list_of_prime), do: Enum.reverse(list_of_prime)
  def sieve([head | tail], num, list_of_prime) do 
    new_list = remove(tail, range(head*2, num, head)) 
    sieve(new_list, num, [head | list_of_prime])
  end


  @doc"""
  Return a list of primes smaller than an integer.  Uses the Erastothene sieve
  """
  def prime_to(value) do
    list = range(2, value)
    primes = sieve(list, value, [])
    length(primes)
  end


end
