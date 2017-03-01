module Render exposing (renderBoard)

import Color exposing (Color, rgb)
import Collage exposing (..)

import Model exposing (..)
import Logic exposing (..)

collageSize : Float
collageSize = 700

backgroundColor : Color
backgroundColor = rgb 225 225 225

renderBackground : Board -> Form
renderBackground board = rect collageSize collageSize |> filled backgroundColor

renderCell : Float -> Board -> Cell -> Form
renderCell size board (x, y) =
  rect size size
  |> filled Color.black
  |> move (toFloat x * size, toFloat y * size)
  |> move ((size - collageSize) / 2, (size - collageSize) / 2)

renderCells : Board -> List Form
renderCells board =
  let
    cellSize = collageSize / (toFloat board.size)
  in
    cells board
    |> List.filter (isAlive board)
    |> List.map (renderCell cellSize board)

renderBoard : Board -> List Form
renderBoard board = renderBackground board :: renderCells board
