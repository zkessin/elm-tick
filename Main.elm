module Main exposing (..)

import Html exposing (..)
import Time exposing (every, minute, second, Time)


-- MODEL


type alias Model =
    { time : Maybe Time.Time
    }


type Msg
    = Tick Time.Time


init : ( Model, Cmd Msg )
init =
    ( Model Nothing, Cmd.none )



-- UPDATE


update : Msg -> Model -> ( Model, Cmd a )
update msg model =
    case msg of
        Tick newTime ->
            ( { model | time = Just newTime }, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    case model.time of
        Just time ->
            p [] [ text <| toString time ]

        Nothing ->
            p [] [ text "Initializing Time" ]



-- APP


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ every second Tick ]


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
