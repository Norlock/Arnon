module Styles exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)

type alias AttrList msg = List (Attribute msg)

container : AttrList msg -> AttrList msg
container list =
      [ style "border-radius" "5px"
      , style "background-color" "#f2f2f2"
      , style "padding" "20px"
      ] ++ list
    
navbar : AttrList msg -> AttrList msg
navbar list =
    [ style "background-color" "#a2c2f2"
    , style "list-style-type" "none"
    , style "margin" "20px"
    , style "display" "flex"
    , style "flex-direction" "row"
    ] ++ list

navbarItem : AttrList msg -> AttrList msg
navbarItem list =
    [ style "background-color" "#22a2a2"
    , style "padding" "20px"
    , style "display" "grid"
    , style "align-items" "center"
    , style "cursor" "pointer"
    ] ++ list

--navbarItemHover : AttrList msg -> AttrList msg
--navbarItem list =
    --[ style "background-color" "#22a2a2"
    --, style "padding" "20px"
    --, style "display" "grid"
    --, style "align-items" "center"
    --] ++ list
