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

renderCell : Float -> Cell -> Form
renderCell size (x, y) =
  rect size size
  |> filled Color.black
  |> move (toFloat x * size, toFloat y * size)
  |> move ((size - collageSize) / 2, (size - collageSize) / 2)

renderCells : Board -> List Form
renderCells board =
  let cellSize = collageSize / (toFloat board.size)
  in List.map (renderCell cellSize) board.livingCells

renderBoard : Board -> List Form
renderBoard board = renderBackground :: renderCells board
