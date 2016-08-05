defmodule BowlingKata.Game do
  defstruct rolls: []

  def roll(game, pins) do
    %{ game | rolls: [pins | game.rolls] }
  end

  def score(game) do
    calculate_score(Enum.reverse(game.rolls), 1, 0)
  end

  defp calculate_score([], _, accumulator) do 
    accumulator
  end

  defp calculate_score([10 | tail], 10, accumulator) do
    accumulator + 10 + strike_bonus(tail)
  end

  defp calculate_score([10 | tail], frame_number, accumulator) do
     accumulated_score = accumulator + 10 + strike_bonus(tail)
     calculate_score(tail, frame_number + 1, accumulated_score)
  end

  defp calculate_score([a | [b | tail]], 10, accumulator) do
     accumulator + a + b + spare_bonus(a + b, tail)
  end


  defp calculate_score([a | [b | tail]], frame_number, accumulator) do
     accumulated_score = accumulator + a + b + spare_bonus(a + b, tail)
     calculate_score(tail, frame_number + 1, accumulated_score)
  end

  defp strike_bonus([x | [y | _]]), do: x + y
  defp strike_bonus([x]), do: x
  defp strike_bonus([]), do: 0

  defp spare_bonus(10, [head | _]), do: head
  defp spare_bonus(_, _), do: 0
end
