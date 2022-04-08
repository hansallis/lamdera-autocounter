module Backend exposing (..)

import Html
import Lamdera exposing (ClientId, SessionId)
import Time
import Types exposing (..)


type alias Model =
    BackendModel


app =
    Lamdera.backend
        { init = init
        , update = update
        , updateFromFrontend = updateFromFrontend
        , subscriptions =
            \m ->
                [ if m.running then
                    Time.every 50 Tick

                  else
                    Sub.none
                , Lamdera.onConnect ClientConnected
                ]
                    |> Sub.batch
        }


init : ( Model, Cmd BackendMsg )
init =
    ( { message = "Hello!", counter = 1, running = False }
    , Cmd.none
    )


update : BackendMsg -> Model -> ( Model, Cmd BackendMsg )
update msg model =
    case msg of
        Tick _ ->
            if model.running then
                ( { model | counter = model.counter + 1 }, Lamdera.broadcast (CounterChanged <| model.counter + 1) )

            else
                ( model, Cmd.none )

        ClientConnected _ clientId ->
            ( model, Lamdera.sendToFrontend clientId <| CounterChanged model.counter )


updateFromFrontend : SessionId -> ClientId -> ToBackend -> Model -> ( Model, Cmd BackendMsg )
updateFromFrontend _ _ msg model =
    case msg of
        StartCounter ->
            ( { model | running = True }, Cmd.none )

        StopCounter ->
            ( { model | running = False }, Cmd.none )
