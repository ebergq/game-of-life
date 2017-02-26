module Model exposing (Board, Cell)

type alias Cell = (Int, Int)

type alias Board =
  { width : Int
  , height : Int
  , livingCells : List Cell }
