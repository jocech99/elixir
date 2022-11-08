defmodule TodoList do
  @moduledoc"""
  Basic module for the todo project
  """
  defstruct auto_id: 1, entries: %{} 


  @doc"""
  Cretate a new Todo list from an existing list of entries
  """
  def new(entries \\ []) do
    Enum.reduce(
      entries,
      %TodoList{},
      &add_entry(&2, &1)
    )
  end


  @doc"""
  Add an entry to the list
  """
  def add_entry(todo_list, entry) do 
    entry = entry |> Map.put(:id, todo_list.auto_id)

    new_entries = Map.put(
      todo_list.entries,
      todo_list.auto_id,
      entry
    )

    %TodoList{
      entries: new_entries,
      auto_id: todo_list.auto_id + 1
    }
  end


  @doc"""
  List all entries for a specific date
  """
  def entries(todo_list, date) do 
    todo_list.entries
    |> Stream.filter(fn {_, entry} -> entry.date == date end)
    |> Enum.map(fn {_, entry} -> entry end)
  end


  @doc"""
  Update an entry specified by its ID, using an update function
  """
  def update_entry(todo_list, id, updater_fun) do
    case Map.fetch(todo_list.entries, id) do
      :error -> 
        todo_list

      {:ok, old_entry} ->
        old_entry_id = old_entry.id
        new_entry = %{id: ^old_entry_id} = updater_fun.(old_entry)
        new_entries = Map.put(todo_list.entries, id, new_entry)
        %TodoList{ todo_list |  entries: new_entries }
    end
  end

  @doc"""
  Update an entry, using an alternate entry
  """
  def update_entry(todo_list, %{} = new_entry) do
    update_entry(todo_list, new_entry.id, fn _ -> new_entry end) 
  end


  @doc"""
  Remove an existing entry, by ID
  """
  def delete_entry(todo_list, id) do
    new_entries = Map.delete(todo_list.entries, id)
    %TodoList{ todo_list | entries: new_entries }
  end

  @doc"""
  Extract number of items in the todo list
  """
  def num_items(todo_list), do: todo_list.auto_id - 1

end  # Module TodoList

###########################################
#  Protocols for TodoList
###########################################
defimpl String.Chars, for: TodoList do
  @doc"""
  Definition of the to_string method of the String.Chars protocol
  """
  def to_string(todo_list) do
     "#TodoList #{TodoList.num_items(todo_list)}"
  end
end

defimpl Collectable, for: TodoList do
  @doc"""
  Definition of the "into" method of the Collectable protocol
  """
  def into(original) do
    callback_fun = fn
      todo_list, {:cont, entry} -> todo_list |> TodoList.add_entry(entry)
      todo_list, :done -> todo_list
      _todo_list, :halt -> :ok 
    end
    {original, callback_fun}
  end
end
  

###########################################
# Importer module
# #########################################
defmodule TodoList.CsvImporter do
  @moduledoc"""
  Importer for the CSV project
  """

  @doc"""
  Import a new todo list from file
  """
  def import(filepath) do
    File.stream!(filepath) 
    |> CSV.decode
    |> Stream.map(fn {:ok, list} -> list end)
    |> Stream.map(
      fn line ->
        {:ok, date} = Date.from_iso8601(Enum.at(line, 0))
        %{ 
          date: date,
          title: Enum.at(line, 1)
        } 
      end
    )
    |> TodoList.new()
  end

end # Module TodoList.csv_importer 
