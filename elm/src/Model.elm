module Model exposing (Board, Cell)

type alias Cell = (Int, Int)

type alias Board =
  { size : Int
  , livingCells : List Cell }
