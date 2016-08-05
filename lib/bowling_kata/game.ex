defmodule BowlingKata.Game do
  defstruct rolls: []

  def roll(game, pins) do
    %{ game | rolls: [pins | game.rolls] }
  end

  def score(game) do
    calculate_score(Enum.reverse(game.rolls), frame: 1)
  end

  defp calculate_score([], frame: _) do
    0
  end

  defp calculate_score([10 | tail], frame: 10) do
    10 + strike_bonus(tail)
  end

  defp calculate_score([10 | tail], frame: frame) do
    10 + strike_bonus(tail) + calculate_score(tail, frame: frame + 1)
  end

  defp calculate_score([x | [y | [z | []]]], frame: 10) do
    x + y + z
  end

  defp calculate_score([x | [y | tail]], frame: frame) do
    sum = x + y
    sum + spare_bonus(sum, tail) + calculate_score(tail, frame: frame + 1)
  end

  defp strike_bonus([x | [y | _]]), do: x + y

  defp spare_bonus(10, [x | _]), do: x
  defp spare_bonus(_, _), do: 0
end
