module Main exposing (..)

-- Press buttons to increment and decrement a counter.
--
-- Read how it works:
--   https://guide.elm-lang.org/architecture/buttons.html
--


import Browser
import Html exposing (Html, button, div, text, p)
import Html.Events exposing (onClick)
import Array exposing (..)
import Html.Attributes exposing (class, id)


-- MAIN


main =
  Browser.sandbox { init = defbingo, update = update, view = view }



-- MODEL


type alias Model = 
    { amount: Int
    , width: Int
    , activated: Array Bool
    }


init : Int -> Model
init s =
    { amount = s*s
    , width = s
    , activated = repeat (s*s + 1) False
    }


defbingo = init 3


-- UPDATE


type Msg = Tap Int


update : Msg -> Model -> Model
update msg model =
  case msg of
   Tap pos -> {model | activated = set pos True model.activated}


-- VIEW


view : Model -> Html Msg
view model =
    let box i = div [onClick (Tap i)
             , class (if (Maybe.withDefault False (get i model.activated)) then "active" else "inactive")
             , id (String.fromInt i)
             ]
             
             [p [] [ text (String.fromInt i)]]
    in
        div [id "bingo"] (List.map box (List.range 1 model.amount))
