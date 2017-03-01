import Model exposing (Board, Cell)
import Logic exposing (transition)
import AsciiBoard exposing (show)
import Examples exposing (gosperGliderGun)

import Html exposing (Html)
import Html.Attributes as Att
import Time exposing (Time)

type alias Model =
  { board: Board
  , ticks: Int
  }

type Msg = Tick Time

onTick model =
  ( { model | board = transition model.board, ticks = model.ticks + 1 }
  , Cmd.none
  )

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Tick time -> onTick model

board : Model -> String
board model = show model.board

view : Model -> Html Msg
view model =
  Html.div [Att.class "container"]
  [ Html.pre [Att.class "board"] [ Html.text (board model) ]
  , Html.pre [Att.class "score"]
      [ Html.text ("Transitions: " ++ toString model.ticks) ]
  ]

subscriptions : Model -> Sub Msg
subscriptions model = Sub.batch [Time.every (Time.second/2) Tick]

init : (Model, Cmd Msg)
init = ({ board = gosperGliderGun, ticks = 0 }, Cmd.none)

main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }
