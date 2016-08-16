defmodule BowlingKata.Game do
  defstruct rolls: []

  def roll(game, pins) do
    %{ game | rolls: [pins | game.rolls] }
  end

  def score(game) do
    calculate_score(Enum.reverse(game.rolls), 1)
  end

  defp calculate_score([], _) do
    0
  end

  defp calculate_score(tail, 10) do
    Enum.reduce(tail, 0, &(&1 + &2))
  end

  defp calculate_score([10 | tail], accumulator) do
    10 + strike_bonus(tail) + calculate_score(tail, accumulator + 1)
  end

  defp calculate_score([first_roll | [second_roll | tail]], accumulator) do
    first_roll + second_roll + spare_bonus(first_roll + second_roll, tail) + calculate_score(tail, accumulator + 1)
  end

  defp strike_bonus([first_roll | [second_roll | tail]]) do
    first_roll + second_roll
  end

  defp spare_bonus(10, [next_roll | tail]) do
    next_roll
  end

  defp spare_bonus(_, _) do
    0
  end
end
