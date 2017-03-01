module AsciiBoard exposing (show)

import Model exposing (Board, Cell)
import Logic exposing (cells, isAlive)

chunkBySize : Int -> List a -> List (List a)
chunkBySize size list = case list of
  [] -> []
  _  -> List.take size list :: chunkBySize size (List.drop size list)

getChar : Board -> Cell -> Char
getChar board cell = if isAlive board cell then '#' else '.'

show : Board -> String
show board =
  cells board
  |> List.map (getChar board)
  |> chunkBySize board.size
  |> List.map String.fromList
  |> List.intersperse "\n"
  |> String.concat
