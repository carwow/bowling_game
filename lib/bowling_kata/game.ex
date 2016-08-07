defmodule BowlingKata.Game do
  defstruct rolls: []

  def roll(game, pins) do
    %{ game | rolls: [pins | game.rolls] }
  end

  def score(game) do
    game_score(Enum.reverse(game.rolls), frame_number: 1, current_score: 0)
  end

  defp game_score([], frame_number: _, current_score: score) do
    score
  end

  defp game_score(rolls, frame_number: 10, current_score: score) do
    {frame_score, _} = frame_score(rolls)
    score + frame_score
  end

  defp game_score(rolls, frame_number: number, current_score: score) do
    {frame_score, remaining_rolls} = frame_score(rolls)
    game_score(remaining_rolls, frame_number: number + 1, current_score: score + frame_score)
  end

  defp frame_score([10 | tail]) do
    frame_score = 10 + strike_bonus(tail)
    {frame_score, tail}
  end

  defp frame_score([first_roll | [second_roll | tail]]) do
    frame_score = first_roll + second_roll + spare_bonus(first_roll + second_roll, tail)
    {frame_score, tail}
  end

  defp strike_bonus([x | [y | _]]), do: x + y
  defp strike_bonus([x]), do: x
  defp strike_bonus([]), do: 0

  defp spare_bonus(10, [head | _]), do: head
  defp spare_bonus(_, _), do: 0
end
