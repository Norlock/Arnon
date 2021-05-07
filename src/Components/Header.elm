module Components.Header exposing (header)
import Html exposing (..)
import Messages exposing (Msg)
import Html.Attributes exposing (..)

navbar : List String -> Html Msg
navbar tabTitles =
    tabTitles 
      |> List.map
        (\title ->
          li [ class "navbar-item"] [ text title ]
        )
      |> ul [ class "navbar-list" ]

header :  Html Msg
header = 
  div [ class "header" ] 
      [ h1 [] [text "Fashion store"]
      , div [ class "navbar" ]
        [ navbar ["Home", "Fashion", "Discount", "Contact"] 
        , span [ class "login-container" ] [ text "login" ]
        ]
      ]

