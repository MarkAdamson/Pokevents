unit PEATypes;

interface

uses
  SysUtils, Classes, Spring, Spring.Collections;

type
  TGame = (gaSun, gaMoon, gaUltraSun, gaUltraMoon, gaGO, gaSword, gaShield,
      gaLetsGoEevee, gaLetsGoPikachu, gaBrilliantDiamond, gaShiningPearl,
      gaPLA, gaHome, gaScarlet, gaViolet);
  TGames = set of TGame;
  TGender = (geNone, geMale, geFemale);
  TRegion = (reWorldwide, reAmerica, reJapan, reEurope, reOther);

  TPokevent = record
    Title, Species, Description, Kind: String;
    Region: TRegion;
    Gender: Nullable<TGender>;
    Ball, OT, TID, Ability, HoldItem, Nature, Code: TNullableString;
    Level: TNullableInteger;
    Marks, Moves, Ribbons, Locations: IList<String>;
    Shiny, Gigantamax: Boolean;
    StartDate: TDateTime;
    EndDate: TNullableDateTime;
    Games: TGames;
    procedure Clear;
    procedure Validate;
  end;

  IPokeventsAPI = interface (IInvokable)
    ['{6FA3AFEA-633E-4F3F-8622-F15A8899B6DC}']
    function GetEvents: IDictionary<String,TPokevent>;
    function CreateEvent(Event: TPokevent): String;
    procedure UpdateEvent(ID: String; Event: TPokevent);
    procedure DeleteEvent(ID: String);
  end;

  EPokeventsError = class (Exception);

  EPokeventsAPIError = class (EPokeventsError);
  EPokeventValidationException = class (EPokeventsError);

function RegionFromName(Name: String): TRegion;
function GenderFromName(Name: String): TGender;
function GameFromCode(Code: String): TGame;

const
  GameName: array[TGame] of String =
    ('Sun', 'Moon', 'Ultra Sun', 'Ultra Moon', 'GO', 'Sword', 'Shield',
     'Let''s Go, Eevee!', 'Let''s Go, Pikachu!', 'Brilliant Diamond',
     'Shining Pearl', 'Legends: Arceus', 'Home', 'Scarlet', 'Violet');
  GameCode: array[TGame] of String =
    ('S','M','US','UM','GO','SW','SH','LGE','LGP','BD','SP','LA','HO','SC','VI');
  GenderName: array[TGender] of String =
    ('None', 'Male', 'Female');
  RegionName: array[TRegion] of String =
    ('Worldwide', 'America', 'Japan', 'Europe', 'Other');

implementation

uses
  Variants, DateUtils;

{ TPokevent }

procedure TPokevent.Clear;
begin
  Title := '';
  Species := '';
  Description := '';
  Kind := '';
  Region := reWorldwide;
  Gender := Null;
  Ball := Null;
  OT := Null;
  TID := Null;
  Ability := Null;
  HoldItem := Null;
  Nature := Null;
  Code := Null;
  Level := Null;
  Marks := TCollections.CreateList<String>;
  Moves := TCollections.CreateList<String>;
  Ribbons := TCollections.CreateList<String>;
  Locations := TCollections.CreateList<String>;
  Shiny := False;
  Gigantamax := False;
  StartDate := 0;
  EndDate := Null;
  Games := [];
end;

procedure TPokevent.Validate;
begin
  var Errors: TStrings := TStringList.Create;
  try
    if String.IsNullOrWhitespace(Title) then
      Errors.Add(' • No title');
    if String.IsNullOrWhiteSpace(Description) then
      Errors.Add(' • No description');
    if String.IsNullOrWhitespace(Kind) then
      Errors.Add(' • No type');
    if StartDate = 0 then
      Errors.Add(' • No start date');
    if Locations.IsEmpty then
      Errors.Add(' • No locations');
    if String.IsNullOrWhitespace(Species) then
      Errors.Add(' • No species');
    if Moves.Count > 4 then
      Errors.Add(' • Too many moves');
    if Games = [] then
      Errors.Add(' • No games');

    if Errors.Count > 0 then
      raise EPokeventValidationException.Create(Errors.Text);
  finally
    Errors.Free;
  end;
end;

function RegionFromName(Name: String): TRegion;
begin
  for Result := Low(TRegion) to High(TRegion) do
    if SameText(Name, RegionName[Result]) then
      Exit;

  raise EPokeventsError.CreateFmt('Unknown region: %s', [Name]);
end;

function GenderFromName(Name: String): TGender;
begin
  for Result := Low(TGender) to High(TGender) do
    if SameText(Name, GenderName[Result]) then
      Exit;

  raise EPokeventsError.CreateFmt('Unknown Gender: %s', [Name]);
end;

function GameFromCode(Code: String): TGame;
begin
  for Result := Low(TGame) to High(TGame) do
    if SameText(Code, GameCode[Result]) then
      Exit;

  raise EPokeventsError.CreateFmt('Unknown Game: %s', [Code]);
end;

end.
