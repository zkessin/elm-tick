module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)


-- MODEL


type alias Model =
    { count : Int
    , input : Result ( String, String ) Int
    }


type Msg
    = Increment
    | Reset
    | SetCount String


init : Model
init =
    Model 0 (Ok 0)



-- UPDATE


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            { model | count = model.count + 1, input = Ok <| model.count + 1 }

        Reset ->
            { model | count = 0, input = Ok 0 }

        SetCount str ->
            if str == "-" then
                { model | input = Err ( "", str ) }
            else
                case String.toInt str of
                    Ok v ->
                        { model | count = v, input = Ok v }

                    Err error ->
                        { model | input = Err ( error, str ) }



-- VIEW


view : Model -> Html Msg
view model =
    div [ style [ ( "margin", "20px" ) ] ]
        [ div []
            [ text <| toString model.count
            , text " "
            , br [] []
            , button [ onClick Increment ] [ text "+" ]
            , button [ onClick Reset ] [ text "Reset" ]
            ]
        , input
            [ onInput <| SetCount
            , value <|
                case model.input of
                    Ok i ->
                        toString i

                    Err ( _, v ) ->
                        v
            ]
            []
        , br [] []
        , case model.input of
            Ok _ ->
                text ""

            Err ( error, v ) ->
                text error
        ]



-- APP


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = init
        , view = view
        , update = update
        }
