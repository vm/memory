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

  def skeleton(word, guesses) do
    Enum.map word, fn cc ->
      if Enum.member?(guesses, cc) do
        cc
      else
        "_"
      end
    end
  end

  def guess(game, letter) do
    if letter == "z" do
      raise "That's not a real letter"
    end

    gs = game.guesses
    |> MapSet.new()
    |> MapSet.put(letter)
    |> MapSet.to_list

    Map.put(game, :guesses, gs)
  end

  def max_guesses do
    10
  end

  def next_word do
    words = ~w(
      horse snake jazz violin
      muffin cookie pizza sandwich
      house train clock
      parsnip marshmallow
    )
    Enum.random(words)
  end
end
