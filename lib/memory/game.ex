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
end
