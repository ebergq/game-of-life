import Model exposing (Board)
import Logic exposing (transition)
import Examples exposing (..)
import Render exposing (renderBoard)

import AnimationFrame
import Collage exposing (collage)
import Element exposing (toHtml)
import Html exposing (Html)
import Html.Attributes as Attr
import Time exposing (Time)

type alias Model =
  { board: Board Bool
  , ticks: Int
  }

type Msg = Tick

onTick : Model -> (Model, Cmd Msg)
onTick model =
  { model | board = transition model.board, ticks = model.ticks + 1 } ! []

collageSize : Int
collageSize = 700

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Tick -> onTick model

view : Model -> Html Msg
view model =
  Html.div
    [ Attr.class "container" ]
    [ toHtml (collage collageSize collageSize (renderBoard model.board))]

subscriptions : Model -> Sub Msg
subscriptions model =
  AnimationFrame.diffs (always Tick)

init : (Model, Cmd Msg)
init = { board = gosperGliderGun, ticks = 0 } ! []

main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }
