defmodule BowlingKata.Game do
  defstruct rolls: []

  def roll(game, pins) do
    %{ game | rolls: [pins | game.rolls] }
  end

  def score(game) do
    calculate_score(Enum.reverse(game.rolls), 1)
  end

  def strike_bonus([x | [y | _]]) do
    x + y
  end

  def strike_bonus([]) do
    0
  end

  def calculate_score([10 | tail], 10) do
    10 + strike_bonus(tail)
  end

  def calculate_score([10 | tail], frame_number) do
    10 + strike_bonus(tail) + calculate_score(tail, frame_number + 1)
  end

  def calculate_score([], _) do
    0
  end

  def calculate_score([a | [b | tail]], frame_number) do
    frame_score = a + b
    frame_score + spare_bonus(frame_score, tail) + calculate_score(tail, frame_number + 1)
  end

  def spare_bonus(10, [head | _]) do
    head
  end

  def spare_bonus(_, _) do
    0
  end
end
