defmodule BowlingKata.GameTest do
  use ExUnit.Case
  alias BowlingKata.Game # This means we can refer to BowlingKata.Game as just Game

  test "gutter game" do
    game = run_many(%Game{}, 20, 0)

    assert Game.score(game) == 0
  end

  test "rolling all ones" do
    game = run_many(%Game{}, 20, 1)

    assert Game.score(game) == 20
  end

  test "rolling one spare" do
    game = %Game{}
    |> run_rolls([5, 5, 3])
    |> run_many(17, 0)

    assert Game.score(game) == 16
  end

  test "rolling one strike" do
    game = %Game{}
    |> run_rolls([10, 3, 4])
    |> run_many(16, 0)

    assert Game.score(game) == 24
  end

  test "perfect game" do
    game = %Game{}
    |> run_many(10, 10)
    |> run_many(2, 10)

    assert Game.score(game) == 300
  end

  test "spare" do
    game = %Game{}
    |> run_many(18, 0)
    |> run_rolls([3, 7, 5])

    assert Game.score(game) == 15
  end

  def run_many(game, n, value) do
    rolls = Enum.map(1..n, fn _ -> value end)
    run_rolls(game, rolls)
  end

  def run_rolls(game, rolls) do
    Enum.reduce(rolls, game, fn pins, game ->
      Game.roll(game, pins)
    end)
  end
end
