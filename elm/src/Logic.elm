module Logic exposing (transition)

import Model exposing (Board, apply, neighbours)

numberOfAliveNeighbours : Int -> Int -> Board Bool -> Int
numberOfAliveNeighbours x y board =
  neighbours x y board
  |> List.filter identity
  |> List.length

transition : Board Bool -> Board Bool
transition board =
  let shouldBeAlive x y isAlive =
    let n = numberOfAliveNeighbours x y board
    in n == 3 || n == 2 && isAlive
  in apply shouldBeAlive board
