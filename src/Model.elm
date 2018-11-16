module Model exposing (init, inputToString, formKeyToString, Msg(..), Model, Step, Input(..), FormData)

-- Imports
import Html exposing (Attribute, Html, input)
import Html.Attributes exposing (type_)

-- Application Messages
type Msg
  = SetName
  | SetAge
  | NextStep

-- Input type alias
type Input
  = Text
  | Number
  | Button
  | Hidden

-- Convert input to JS-recognizable string
inputToString: Input -> String
inputToString input =
  case input of
    Text    -> "text"
    Number  -> "number"
    Button  -> "button"
    Hidden  -> "hidden"

-- FormKey type definition
type FormKey
  = Name
  | Age

-- Convert FormKey to JS-recognizable string
formKeyToString: FormKey -> String
formKeyToString key =
  case key of
    Name  -> "name"
    Age   -> "age"

-- Application step
type alias Step =
  { label: String
  , inputType: Input
  , dataKey: Maybe FormKey
  , submit: Msg
  }

-- Form data structure
type alias FormData =
  { name: Maybe String
  , age: Maybe Int
  }

-- Application Model
type alias Model =
  { steps: List (Maybe Step)
  , name: Maybe String
  , formData: FormData
  }

-- First Step : Ask user to begin
initialStep: Step
initialStep =
  { label = "Commencer"
  , inputType = Hidden
  , dataKey = Nothing
  , submit = NextStep
  }

-- Step : 
nameStep: Step
nameStep =
  { label = "Nom"
  , inputType = Text
  , dataKey = Just Name
  , submit = SetName
  }

-- Third step : Ask user
ageStep: Step
ageStep =
  { label = "Age"
  , inputType = Number
  , dataKey = Just Age
  , submit = SetAge
  }

-- Combine app steps
combinedSteps: List (Maybe Step)
combinedSteps =
  List.map (\x -> Just x)
    [ initialStep
    , nameStep
    , ageStep
    ]

-- Application initialization
init: Model
init =
  { steps = combinedSteps
  , name = Nothing
  , formData =
    { name = Nothing
    , age = Nothing
    }
  }
