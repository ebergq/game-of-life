import Model exposing (Board, Cell)
import Logic exposing (transition)
import AsciiBoard exposing (show)
import Examples exposing (..)
import Render exposing (renderBoard)

import Collage exposing (collage)
import Element exposing (toHtml)
import Html exposing (Html)
import Html.Attributes as Attr
import Time exposing (Time)

type alias Model =
  { board: Board
  , ticks: Int
  }

type Msg = Tick Time

onTick : Model -> (Model, Cmd Msg)
onTick model =
  { model | board = transition model.board, ticks = model.ticks + 1 } ! []

collageSize : Int
collageSize = 700

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Tick time -> onTick model

board : Model -> String
board model = show model.board

view : Model -> Html Msg
view model =
  Html.div
    [ Attr.class "container" ]
    [ toHtml (collage collageSize collageSize (renderBoard model.board))]

subscriptions : Model -> Sub Msg
subscriptions model = Sub.batch [Time.every (Time.second/10) Tick]

init : (Model, Cmd Msg)
init = { board = gosperGliderGun, ticks = 0 } ! []

main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }
