module Components.Header exposing (header)
import Html exposing (..)
import Messages exposing (Msg)
import Styles
import Html.Attributes exposing (..)

navbar : List String -> Html Msg
navbar tabTitles =
    tabTitles 
      |> List.map
        (\title ->
          li (Styles.navbarItem [class "nav-item"]) [ text title ]
        )
      |> ul (Styles.navbarList [])

header :  Html Msg
header = 
  div [] 
      [ node "link" [ rel "stylesheet", href "/public/styles/index.css" ] []
      , h1 [] [text "Fashion store"]
      , div (Styles.navbar []) 
        [ navbar ["Home", "Fashion", "Discount", "Contact"] 
        , span (Styles.loginContainer []) [ text "login" ]
        ]
      ]

