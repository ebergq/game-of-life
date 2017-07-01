module Render exposing (renderBoard)

import Color exposing (Color, rgb)
import Collage exposing (..)

import Model exposing (..)
import Logic exposing (..)

collageSize : Float
collageSize = 700

backgroundColor : Color
backgroundColor = rgb 225 225 225

renderBackground : Form
renderBackground = rect collageSize collageSize |> filled backgroundColor

renderCell : Float -> (Int, Int, Bool) -> Form
renderCell size (x, y, isAlive) =
  rect size size
  |> filled (if isAlive then Color.black else Color.white)
  |> move (toFloat x * size, toFloat y * size)
  |> move ((size - collageSize) / 2, (size - collageSize) / 2)

renderCells : Board Bool -> List Form
renderCells board =
  let cellSize = collageSize / (toFloat (Tuple.first board.size))
  in
    board
    |> extract
    |> List.filter (\(_, _, v) -> v)
    |> List.map (renderCell cellSize)

renderBoard : Board Bool -> List Form
renderBoard board = renderBackground :: renderCells board
