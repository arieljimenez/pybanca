module Models exposing (Model, modelInitialValue, Msg(..))

import Http exposing (Error)
import Models.User exposing (User)


type alias Model =
    { userList : List User }


modelInitialValue : Model
modelInitialValue =
    { userList = [] }


type Msg
    = OnFetchUsers (Result Http.Error (List User))
