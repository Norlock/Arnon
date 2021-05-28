module Components.Dialog exposing (dialog)

import Html exposing (..)
import Html.Attributes exposing (..)
import Types exposing (..)


dialog : DialogId -> DialogData -> Html Msg
dialog dialogId data =
    showDialog (dialogId == data.dialog) data


showDialog : Bool -> DialogData -> Html Msg
showDialog show data =
    div [ class "dialog" ]
        [ div [ class "dialog-header" ]
            [ span [] [ text data.title ]
            , img [] []
            ]
        , div [ class "dialog-body" ] [ data.body ]
        ]
        |> (\container -> overlay container show)


overlay : Html Msg -> Bool -> Html Msg
overlay content show =
    if show then
        div [ class "overlay show" ] [ content ]

    else
        div [ class "overlay" ] [ content ]
