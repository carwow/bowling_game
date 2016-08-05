defmodule BowlingKata.Game do
  defstruct rolls: []

  def roll(game, pins) do
    %{ game | rolls: [pins | game.rolls] }
  end

  def score(game) do
    calculate_score(Enum.reverse(game.rolls), 1)
  end

  def calculate_score([], _) do
    0
  end

  def calculate_score([10 | tail], 10) do
    10 + strike_bonus(tail)
  end

  def calculate_score([10 | tail], frame) do
      10 + strike_bonus(tail) + calculate_score(tail, frame + 1)
  end


  def calculate_score([x | [y | [z | []]]], 10) do
    x + y + z
  end

  def calculate_score([x | [y | tail]], frame) do
    sum = x + y
    sum + spare_bonus(sum, tail) + calculate_score(tail, frame + 1)
  end

  def strike_bonus([x | [y | _]]), do: x + y

  def spare_bonus(10, [x | _]), do: x
  def spare_bonus(_, _), do: 0
end
