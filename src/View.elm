module View exposing (view)

-- Imports
import Html exposing (Html, Attribute, div, text, form, input, button)
import Html.Attributes exposing (type_, placeholder, value)
import Html.Events exposing (onSubmit)
import Json.Decode as Json

-- Local imports
import Model exposing (Model, Msg(..), Input(..), Step, inputToString)

-- App main view
view: Model -> Html Msg
view model =
  let
    currentStep: Maybe Step
    currentStep =
      case List.head model.steps of
        Just x  -> x
        Nothing -> Nothing
    
    eltList: List (Html Msg)
    eltList =
      case currentStep of
        Just step ->
          [ form [ onSubmit step.submit ]
            [ getInput step
            , input [ type_ "submit" ] [ text "Suivant" ]
            ]
          , div [] (renderFormData model)
          ]
      
        Nothing ->
          [ div [] (renderFormData model)
          ]
  in
    div [] eltList
      

-- Render form data
renderFormData: Model -> List (Html Msg)
renderFormData model =
  List.filter (\x -> case x of
    Just _  -> True
    Nothing -> False
  )
    [ model.formData.name
    , Maybe.map String.fromInt model.formData.age
    ]
    |> List.map (\x -> case x of
      Just str  -> str
      Nothing   -> ""
    )
    |> List.map wrapInDiv

-- Wrap string in div
wrapInDiv: String -> Html Msg
wrapInDiv str =
  div [] [ text str ]

-- Get input element for Step
getInput: Step -> Html Msg
getInput step =
  let
    property: String -> Attribute msg
    property =
      case step.inputType of
        Hidden ->
          value

        Button ->
          value

        Text ->
          placeholder
        
        Number ->
          placeholder
  in
    input [ type_ (inputToString step.inputType), property step.label ] []
