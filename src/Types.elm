module Types exposing (..)

import Browser exposing (UrlRequest)
import Browser.Navigation exposing (Key)
import Lamdera
import Time
import Url exposing (Url)


type alias FrontendModel =
    { key : Key
    , message : String
    , counter : Maybe Int
    }


type alias BackendModel =
    { message : String
    , counter : Int
    , running : Bool
    }


type FrontendMsg
    = UrlClicked UrlRequest
    | UrlChanged Url
    | StopClicked
    | StartClicked
    | NoOpFrontendMsg


type ToBackend
    = StartCounter
    | StopCounter


type BackendMsg
    = Tick Time.Posix
    | ClientConnected Lamdera.SessionId Lamdera.ClientId


type ToFrontend
    = CounterChanged Int
