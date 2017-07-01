module Model exposing (Board, apply, extract, makeBoard, neighbours)

import Array
import Matrix exposing (Matrix)
import Matrix.Extra

type alias Board a = Matrix a

makeBoard : Int -> List (Int, Int) -> Board Bool
makeBoard size livingCells =
  Matrix.repeat size size False
  |> Matrix.indexedMap (\x y _ -> List.member (x, y) livingCells)

apply : (Int -> Int -> a -> b) -> Board a -> Board b
apply f board =
  Matrix.indexedMap f board

neighbours : Int -> Int -> Board a -> List a
neighbours =
  Matrix.Extra.neighbours

extract : Board a -> List (Int, Int, a)
extract matrix =
  matrix
  |> apply (\x y v -> (x, y, v))
  |> toList

toList : Board a -> List a
toList matrix =
  List.range 0 (Matrix.height matrix)
  |> List.map (flip Matrix.getRow matrix >> Maybe.withDefault Array.empty >> Array.toList)
  |> List.concat
