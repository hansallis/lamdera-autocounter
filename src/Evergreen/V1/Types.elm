module Evergreen.V1.Types exposing (..)

import Browser
import Browser.Navigation
import Lamdera
import Time
import Url


type alias FrontendModel =
    { key : Browser.Navigation.Key
    , message : String
    , counter : Maybe Int
    }


type alias BackendModel =
    { message : String
    , counter : Int
    , running : Bool
    }


type FrontendMsg
    = UrlClicked Browser.UrlRequest
    | UrlChanged Url.Url
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
