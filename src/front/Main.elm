module Main exposing (..)

import Html exposing (Html)
import Models exposing (Model, Msg(OnFetchUsers), modelInitialValue)
import Behavior exposing (update)
import Views.View exposing (view)
import Models.User exposing (fetchUsers)


init : ( Model, Cmd Msg )
init =
    ( modelInitialValue, fetchUsers OnFetchUsers )


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = (\_ -> Sub.none)
        }
