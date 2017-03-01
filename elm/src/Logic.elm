module Logic exposing (cells, isAlive, transition)

import Model exposing (Board, Cell)

cartesian : List a -> List b -> List (a, b)
cartesian xs ys = List.concatMap (\y -> List.map (\x -> (x, y)) xs) ys

unique : List a -> List a
unique list = case list of
  []        -> []
  (x :: xs) -> x :: unique (List.filter (\e -> e /= x) xs)

xs : Board -> List Int
xs board = List.range 0 (board.width - 1)

ys : Board -> List Int
ys board = List.range 0 (board.height - 1)

cells : Board -> List Cell
cells board = cartesian (xs board) (ys board)

isAlive : Board -> Cell -> Bool
isAlive board cell = List.member cell board.livingCells

neighbours : Board -> (Int, Int) -> List (Int, Int)
neighbours board (x0, y0) =
  let xRange = List.range -1 1
  in let yRange = List.range -1 1
  in
    cartesian xRange yRange
    |> List.filter (\(x, y) -> x /= 0 || y /= 0)
    |> List.map (\(x, y) -> (x0 + x, y0 + y))
    |> List.filter (\(x, y) -> x >= 0 && y >= 0)
    |> List.filter (\(x, y) -> x < board.width && y < board.height)

numberOfAliveNeighbours : Board -> Cell -> Int
numberOfAliveNeighbours board cell =
  neighbours board cell
  |> List.filter (isAlive board)
  |> List.length

shouldBeAlive : Board -> Cell -> Bool
shouldBeAlive board cell =
  let n = numberOfAliveNeighbours board cell
  in n == 3 || n == 2 && isAlive board cell

transition : Board -> Board
transition board =
  { board | livingCells = board.livingCells
                          |> List.concatMap (neighbours board)
                          |> unique
                          |> List.filter (shouldBeAlive board) }
