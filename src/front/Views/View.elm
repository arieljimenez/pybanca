module Views.View exposing (view)

import Html exposing (Html, text, div, ul, li)
import Models exposing (Model, Msg(..))
import Models.User exposing (User)


view : Model -> Html Msg
view model =
    div []
        [ text "List of users"
        , renderUserList model.userList
        ]


renderUserList : List User -> Html msg
renderUserList list =
    List.map renderUser list
        |> ul []


renderUser : User -> Html msg
renderUser user =
    li [] [ text ("Name: " ++ user.firstname) ]
