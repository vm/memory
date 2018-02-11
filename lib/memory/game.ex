defmodule Memory.Game do
  def new do
    %{
      clicks: 0,
      completed: [],
      checkIndex: nil,
      confirmIndex: nil,
      letters: Memory.Game.randomize_letters(),
    }
  end

  def randomize_letters() do
    letters = ["a", "b", "c", "d", "e", "f", "g", "h"]
    Enum.shuffle(letters ++ letters)
  end

  def clear_indices(game) do
    %{game | confirmIndex: nil, checkIndex: nil}
  end

  def toggle(game, index) do
    cond do
      game[:checkIndex] == nil ->
        %{game | checkIndex: index, clicks: game[:clicks] + 1 }
      game[:confirmIndex] == nil ->
        new_game = %{game | confirmIndex: index, clicks: game[:clicks] + 1 }
        letters = game[:letters]
        if Enum.at(letters, new_game[:confirmIndex]) == Enum.at(letters, new_game[:checkIndex]) do
          new_game = %{new_game | completed: new_game[:completed] ++ [Enum.at(letters, new_game[:confirmIndex])]}
        end
        new_game
      true -> game
    end
  end
end
