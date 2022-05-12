unit PEAService;

interface

uses
  System.SysUtils, System.Classes, Spring.Collections, VirtualObject, PEATypes,
  IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  IdSSLOpenSSLHeaders, IdGlobal;

type
  TdmPEAService = class(TDataModule, IPokeventsAPI)
    http: TIdHTTP;
    ssl: TIdSSLIOHandlerSocketOpenSSL;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function GetEvents: IDictionary<String,TPokevent>;
    function CreateEvent(Event: TPokevent): String;
    procedure UpdateEvent(ID: String; Event: TPokevent);
    procedure DeleteEvent(ID: String);
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses
  DateUtils, Dialogs, JSON, Spring.Container;

type
  TPokeventHelper = record helper for TPokevent
    class operator Implicit(A: TPokevent): TJSONValue;
    class operator Implicit(A: TJSONValue): TPokevent;
  end;

const
  {$I API}

{ TdmPEAService }

function TdmPEAService.CreateEvent(Event: TPokevent): String;
var
  Response: String;
begin
  var URL := Format('%s/events', [API_URL]);
  var JSONEvent: TJSONValue := Event;
  try
//    ShowMessage(JSONEvent.ToJSON);

    var Body := TStringStream.Create(JSONEvent.ToJSON);
    try
      Response := http.Post(URL, Body);
    finally
      Body.Free;
    end;

    var JResponse := TJSONObject.ParseJSONValue(Response) as TJSONObject;
    try
      Result := JResponse.GetValue<String>('ID');
    finally
      JResponse.Free;
    end;
  finally
    JSONEvent.Free;
  end;
end;

procedure TdmPEAService.DataModuleCreate(Sender: TObject);
begin
  http.Request.CustomHeaders.AddValue('x-api-key',API_KEY);
  GIdDefaultTextEncoding := encUTF8;
end;

procedure TdmPEAService.DeleteEvent(ID: String);
begin
  http.Delete(Format('%s/events/%s', [API_URL, ID]));
end;

function TdmPEAService.GetEvents: IDictionary<String, TPokevent>;
begin
  Result := TCollections.CreateDictionary<String,TPokevent>;

  var URL := Format('%s/events', [API_URL]);

  var ResponseText := '';
  var Response := TStringStream.Create('', TEncoding.UTF8);
  try
    http.Get(URL, Response);
    ResponseText := Response.DataString;
  finally
    Response.Free;
  end;

  var JResponse := TJSONObject.ParseJSONValue(ResponseText) as TJSONArray;
  try
    for var i := 0 to JResponse.Count - 1 do
      Result.Add(TJSONObject(JResponse.Items[i]).GetValue<String>('ID'), JResponse.Items[i]);
  finally
    JResponse.Free;
  end;
end;

procedure TdmPEAService.UpdateEvent(ID: String; Event: TPokevent);
begin
  var URL := Format('%s/events/%s', [API_URL, ID]);
  var JSONEvent: TJSONValue := Event;
  try
    var Body := TStringStream.Create(JSONEvent.ToJSON);
    try
      http.Put(URL, Body);
    finally
      Body.Free;
    end;
  finally
    JSONEvent.Free;
  end;
end;

{ TPokeventHelper }

class operator TPokeventHelper.Implicit(A: TJSONValue): TPokevent;
var
  tmp: String;
  tmpint: Integer;

  procedure GetStrings(Key: String; List: IList<String>);
  begin
    var Arr := A.GetValue<TJSONArray>(Key);
    for var i := 0 to Arr.Count - 1 do
      List.Add(Arr[i].AsType<String>);
  end;

begin
  var O := A as TJSONObject;

  Result.Clear;
  Result.Title := O.GetValue<String>('Title');
  Result.Species := O.GetValue<String>('Species');
  Result.Description := O.GetValue<String>('Description');
  Result.Kind := O.GetValue<String>('Type');
  Result.Region := RegionFromName(O.GetValue<String>('Region'));
  if O.TryGetValue<String>('Gender', tmp) then
    Result.Gender := GenderFromName(tmp);
  if O.TryGetValue<String>('Ball', tmp) then
    Result.Ball := tmp;
  if O.TryGetValue<String>('OT', tmp) then
    Result.OT := tmp;
  if O.TryGetValue<String>('TID', tmp) then
    Result.TID := tmp;
  if O.TryGetValue<String>('Ability', tmp) then
    Result.Ability := tmp;
  if O.TryGetValue<String>('HoldItem', tmp) then
    Result.HoldItem := tmp;
  if O.TryGetValue<String>('Nature', tmp) then
    Result.Nature := tmp;
  if O.TryGetValue<String>('Code', tmp) then
    Result.Code := tmp;
  if O.TryGetValue<Integer>('Level', tmpint) then
    Result.Level := tmpint;
  Result.Shiny := O.GetValue<Boolean>('Shiny');
  Result.Gigantamax := O.GetValue<Boolean>('Gigantamax');
  Result.StartDate := ISO8601ToDate(O.GetValue<String>('StartDate'));
  if O.TryGetValue<String>('EndDate', tmp) then
    Result.EndDate := ISO8601ToDate(tmp);

  GetStrings('Moves', Result.Moves);
  GetStrings('Marks', Result.Marks);
  GetStrings('Ribbons', Result.Ribbons);
  GetStrings('Locations', Result.Locations);

  var Arr := A.GetValue<TJSONArray>('Games');
    for var i := 0 to Arr.Count - 1 do
      Include(Result.Games, GameFromCode(Arr[i].AsType<String>));
end;

class operator TPokeventHelper.Implicit(A: TPokevent): TJSONValue;
var
  lvResult: TJSONObject;

  procedure AddStrings(Key: String; Strings: IList<String>);
  begin
    var Arr := TJSONArray.Create;
    for var Str in Strings do
      Arr.Add(Str);
    lvResult.AddPair(Key, Arr);
  end;
begin
  lvResult := TJSONObject.Create;

  lvResult.AddPair('Title', A.Title.Trim);
  lvResult.AddPair('Species', A.Species.Trim);
  lvResult.AddPair('Description', A.Description.Trim);
  lvResult.AddPair('Type', A.Kind.Trim);
  lvResult.AddPair('Region', RegionName[A.Region]);
  if A.Gender.HasValue then
    lvResult.AddPair('Gender', GenderName[A.Gender.Value]);
  if A.Ball.HasValue and not String.IsNullOrWhiteSpace(A.Ball) then
    lvResult.AddPair('Ball', A.Ball.Value.Trim);
  if A.OT.HasValue and not String.IsNullOrWhiteSpace(A.OT) then
    lvResult.AddPair('OT', A.OT.Value.Trim);
  if A.TID.HasValue and not String.IsNullOrWhiteSpace(A.TID) then
    lvResult.AddPair('TID', A.TID.Value.Trim);
  if A.Ability.HasValue and not String.IsNullOrWhiteSpace(A.Ability) then
    lvResult.AddPair('Ability', A.Ability.Value.Trim);
  if A.HoldItem.HasValue and not String.IsNullOrWhiteSpace(A.HoldItem) then
    lvResult.AddPair('HoldItem', A.HoldItem.Value.Trim);
  if A.Nature.HasValue and not String.IsNullOrWhiteSpace(A.Nature) then
    lvResult.AddPair('Nature', A.Nature.Value.Trim);
  if A.Code.HasValue and not String.IsNullOrWhiteSpace(A.Code) then
    lvResult.AddPair('Code', A.Code.Value.Trim);
  if A.Level.HasValue then
    lvResult.AddPair('Level', TJSONNumber.Create(A.Level.Value));
  lvResult.AddPair('Shiny', TJSONBool.Create(A.Shiny));
  lvResult.AddPair('Gigantamax', TJSONBool.Create(A.Gigantamax));
  lvResult.AddPair('StartDate', DateToISO8601(DateOf(A.StartDate)));
  if A.EndDate.HasValue then
    lvResult.AddPair('EndDate', DateToISO8601(DateOf(A.EndDate.Value)));

  AddStrings('Moves', A.Moves);
  AddStrings('Marks', A.Marks);
  AddStrings('Ribbons', A.Ribbons);
  AddStrings('Locations', A.Locations);

  var Games := TJSONArray.Create;
  for var Game := Low(TGame) to High(TGame) do
    if Game in A.Games then
      Games.Add(GameCode[Game]);
  lvResult.AddPair('Games', Games);

  Result := lvResult;
end;

initialization
  TVirtualObject<TdmPEAService,IPokeventsAPI>.Register(GlobalContainer);

end.
