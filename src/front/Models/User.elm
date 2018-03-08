module Models.User exposing (..)

import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline exposing (decode, required, optional)
import Http exposing (Error, send, get)
import Utils exposing (apiUrl)


type alias User =
    { id : Int
    , firstname : String
    , lastname : String
    , username : String
    , password : String
    , status : TypeStatusUser
    , created_at: String
    }


type TypeStatusUser
    = Active
    | Inactive
    | Disabled


userDefaultValue : User
userDefaultValue =
    { id = 0
    , firstname = ""
    , lastname = ""
    , username = ""
    , password = ""
    , status = Active
    , created_at = ""
    }


fetchUsers : (Result Http.Error (List User) -> msg) -> Cmd msg
fetchUsers msg =
    Http.get (apiUrl ++ "/users") usersDecoder
        |> Http.send msg


usersDecoder : Decoder (List User)
usersDecoder =
    Decode.list userDecoder


userDecoder : Decoder User
userDecoder =
    decode User
        |> required "id" Decode.int
        |> required "firstname" Decode.string
        |> required "lastname" Decode.string
        |> required "username" Decode.string
        |> optional "password" Decode.string ""
        |> required "status" decodeStatus
        |> required "created_at" Decode.string


decodeStatus : Decoder TypeStatusUser
decodeStatus =
    Decode.string
        |> Decode.andThen
            (\str ->
                case str of
                    "Active" ->
                        Decode.succeed Active

                    "Inactive" ->
                        Decode.succeed Inactive

                    "Disabled" ->
                        Decode.succeed Disabled

                    _ ->
                        Decode.fail <| "Unknown userStatus: " ++ str
            )
