defmodule BowlingKata.Game do
  defstruct rolls: []

  def roll(game, pins) do
    %{ game | rolls: [pins | game.rolls] }
  end

  def score(game) do
    calculate_score(Enum.reverse(game.rolls), frame_number: 1)
  end

  defp calculate_score([], frame_number: _) do
    0
  end

  defp calculate_score(rolls, frame_number: 10) do
    {score, _} = calculate_frame_score(rolls)
    score
  end

  defp calculate_score(rolls, frame_number: number) do
    {score, remaining_rolls} = calculate_frame_score(rolls)
    score + calculate_score(remaining_rolls, frame_number: number + 1)
  end

  defp calculate_frame_score([10 | tail]) do
    frame_score = 10 + strike_bonus(tail)
    {frame_score, tail}
  end

  defp calculate_frame_score([first_roll | [second_roll | tail]]) do
    frame_score = first_roll + second_roll + spare_bonus(first_roll + second_roll, tail)
    {frame_score, tail}
  end

  defp strike_bonus([x | [y | _]]), do: x + y
  defp strike_bonus([x]), do: x
  defp strike_bonus([]), do: 0

  defp spare_bonus(10, [head | _]), do: head
  defp spare_bonus(_, _), do: 0
end
