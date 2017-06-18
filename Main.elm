module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Time exposing (Time, every, minute, second)


-- MODEL


type alias Model =
    { time : Maybe Time.Time
    , count : Int
    }


type Msg
    = Tick Time.Time
    | Increment
    | Reset


init : ( Model, Cmd Msg )
init =
    ( Model Nothing 0, Cmd.none )



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick newTime ->
            ( { model | time = Just newTime }, Cmd.none )

        Increment ->
            ( { model | count = model.count + 1 }, Cmd.none )

        Reset ->
            ( { model | count = 0 }, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ div []
            [ text <|
                toString <|
                    Maybe.withDefault 0 <|
                        model.time
            ]
        , case model.time of
            Just time ->
                p [] [ text <| toString time ]

            Nothing ->
                p [] [ text "Initializing Time" ]
        , br [] []
        , div []
            [ text <| toString model.count
            , text ""
            , button [ onClick Increment ] [ text "+" ]
            , button [ onClick Reset ] [ text "Reset" ]
            ]
        ]



-- APP


subscriptions : Model -> Sub Msg
subscriptions model =
    every minute Tick


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
