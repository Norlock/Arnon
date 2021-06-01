module Components.Dialog exposing (dialog)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Types exposing (..)


dialog : DialogId -> DialogData -> Html Msg
dialog dialogId data =
    let
        show =
            data.dialog == dialogId
    in
    div [ class "dialog" ]
        [ div [ class "dialog-header" ]
            [ span [] [ text data.title ]
            , div [ class "close fas fa-times", onClick (ToggleDialog None) ] []
            ]
        , div [ class "dialog-body" ] [ data.body ]
        ]
        |> (\content -> div [ class (containerClassList show) ] [ overlay, content ])


containerClassList : Bool -> String
containerClassList show =
    if show then
        "dialog-container show"

    else
        "dialog-container"


overlay : Html Msg
overlay =
    div [ class "overlay", onClick (ToggleDialog None) ] []
