defmodule BowlingKata.Game do
  defstruct rolls: []

  def roll(game, pins) do
    %{ game | rolls: [pins | game.rolls] }
  end

  def score(game) do
    frame_score(Enum.reverse(game.rolls), 1)
  end

  defp frame_score([], _) do 
    0
  end

  defp frame_score([10 | tail], 10) do
    10 + strike_bonus(tail)
  end

  defp frame_score([10 | tail], frame_number) do
    10 + strike_bonus(tail) + frame_score(tail, frame_number + 1)
  end

  defp frame_score([a | [b | tail]], frame_number) do
    a + b + spare_bonus(a + b, tail) + frame_score(tail, frame_number + 1)
  end

  defp strike_bonus([x | [y | _]]), do: x + y
  defp strike_bonus([x]), do: x
  defp strike_bonus([]), do: 0

  defp spare_bonus(10, [head | _]), do: head
  defp spare_bonus(_, _), do: 0
end
