module Behavior exposing (update)

import Models exposing (Model, Msg(..))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnFetchUsers (Ok users) ->
            { model | userList = users } ! []

        OnFetchUsers (Err err) ->
            let
                _ =
                    Debug.log "Error fetch users" err
            in
                model ! []
