unit PEAMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, dxmdaset, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges,
  dxScrollbarAnnotations, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  dxLayoutcxEditAdapters, dxLayoutContainer, cxContainer, cxGroupBox,
  cxCheckGroup, cxDBCheckGroup, cxDropDownEdit, cxCalendar, cxDBEdit, cxMemo,
  cxCheckBox, cxSpinEdit, cxMaskEdit, cxTextEdit, dxLayoutControl, Vcl.Menus,
  Vcl.StdCtrls, cxButtons, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, PEATypes, System.Actions,
  Vcl.ActnList, cxCustomListBox, cxListBox, DBStringsFrame;

type
  TfrmPEAMain = class(TForm)
    mdsEvents: TdxMemData;
    mdsEventsTitle: TWideStringField;
    mdsEventsSpecies: TWideStringField;
    mdsEventsDescription: TMemoField;
    mdsEventsKind: TWideStringField;
    mdsEventsGender: TSmallintField;
    mdsEventsBall: TWideStringField;
    mdsEventsOT: TWideStringField;
    mdsEventsAbility: TWideStringField;
    mdsEventsNature: TWideStringField;
    mdsEventsCode: TWideStringField;
    mdsEventsTID: TWideStringField;
    mdsEventsLevel: TIntegerField;
    mdsEventsShiny: TBooleanField;
    mdsEventsGigantamax: TBooleanField;
    mdsEventsStartDate: TDateTimeField;
    mdsEventsEndDate: TDateTimeField;
    mdsEventsSun: TBooleanField;
    mdsEventsMoon: TBooleanField;
    mdsEventsUltraSun: TBooleanField;
    mdsEventsUltraMoon: TBooleanField;
    mdsEventsGO: TBooleanField;
    mdsEventsSword: TBooleanField;
    mdsEventsShield: TBooleanField;
    mdsEventsLetsGoEevee: TBooleanField;
    mdsEventsLetsGoPikachu: TBooleanField;
    mdsEventsBrilliantDiamond: TBooleanField;
    mdsEventsShiningPearl: TBooleanField;
    mdsEventsLegendsArceus: TBooleanField;
    mdsEventsAWSID: TWideStringField;
    dtsEvents: TDataSource;
    cxgEventsDBTableView1: TcxGridDBTableView;
    cxgEventsLevel1: TcxGridLevel;
    cxgEvents: TcxGrid;
    mdsEventsRegion: TSmallintField;
    cxgEventsDBTableView1Title: TcxGridDBColumn;
    cxgEventsDBTableView1Region: TcxGridDBColumn;
    dxLayoutControl1Group_Root: TdxLayoutGroup;
    dxLayoutControl1: TdxLayoutControl;
    edtTitle: TcxDBTextEdit;
    liTitle: TdxLayoutItem;
    liRegion: TdxLayoutItem;
    edtSpecies: TcxDBTextEdit;
    liSpecies: TdxLayoutItem;
    cmbBall: TcxDBComboBox;
    liBall: TdxLayoutItem;
    spnLevel: TcxDBSpinEdit;
    liLevel: TdxLayoutItem;
    chkShiny: TcxDBCheckBox;
    liShiny: TdxLayoutItem;
    chkGigantamax: TcxDBCheckBox;
    liGigantamax: TdxLayoutItem;
    liMarks: TdxLayoutItem;
    edtTID: TcxDBTextEdit;
    liTID: TdxLayoutItem;
    edtAbility: TcxDBTextEdit;
    liAbility: TdxLayoutItem;
    edtHoldItem: TcxDBTextEdit;
    liHoldItem: TdxLayoutItem;
    edtNature: TcxDBTextEdit;
    liNature: TdxLayoutItem;
    edtOT: TcxDBTextEdit;
    liOT: TdxLayoutItem;
    liMoves: TdxLayoutItem;
    liRibbons: TdxLayoutItem;
    memDescription: TcxDBMemo;
    liDescription: TdxLayoutItem;
    cmbKind: TcxDBComboBox;
    liKind: TdxLayoutItem;
    liLocations: TdxLayoutItem;
    liGender: TdxLayoutItem;
    deStartDate: TcxDBDateEdit;
    liStartDate: TdxLayoutItem;
    deEndDate: TcxDBDateEdit;
    liEndDate: TdxLayoutItem;
    dxLayoutGroup1: TdxLayoutGroup;
    dxLayoutGroup2: TdxLayoutGroup;
    dxLayoutGroup3: TdxLayoutGroup;
    dxLayoutGroup4: TdxLayoutGroup;
    dxLayoutGroup5: TdxLayoutGroup;
    dxLayoutGroup6: TdxLayoutGroup;
    dxLayoutGroup7: TdxLayoutGroup;
    dxLayoutGroup8: TdxLayoutGroup;
    btnPost: TcxButton;
    dxLayoutGroup9: TdxLayoutGroup;
    dxLayoutGroup10: TdxLayoutGroup;
    dxLayoutGroup11: TdxLayoutGroup;
    dxLayoutGroup12: TdxLayoutGroup;
    chkSun: TcxDBCheckBox;
    liSun: TdxLayoutItem;
    chkMoon: TcxDBCheckBox;
    liMoon: TdxLayoutItem;
    chkUltraSun: TcxDBCheckBox;
    liUltraSun: TdxLayoutItem;
    chkUltraMoon: TcxDBCheckBox;
    liUltraMoon: TdxLayoutItem;
    chkGO: TcxDBCheckBox;
    liGO: TdxLayoutItem;
    chkSword: TcxDBCheckBox;
    liSword: TdxLayoutItem;
    chkShield: TcxDBCheckBox;
    liShield: TdxLayoutItem;
    chkLetsGoEevee: TcxDBCheckBox;
    liLetsGoEevee: TdxLayoutItem;
    chkLetsGoPikachu: TcxDBCheckBox;
    liLetsGoPikachu: TdxLayoutItem;
    chkBrilliantDiamond: TcxDBCheckBox;
    liBrilliantDiamond: TdxLayoutItem;
    chkShiningPearl: TcxDBCheckBox;
    liShiningPearl: TdxLayoutItem;
    chkLegendsArceus: TcxDBCheckBox;
    liLegendsArceus: TdxLayoutItem;
    mdsEventsHoldItem: TWideStringField;
    cmbRegion: TcxDBLookupComboBox;
    dtsRegion: TDataSource;
    dtsGender: TDataSource;
    cmbGender: TcxDBLookupComboBox;
    Actions: TActionList;
    actPost: TAction;
    mdsEventsHome: TBooleanField;
    liHome: TdxLayoutGroup;
    chkHome: TcxDBCheckBox;
    dxLayoutItem1: TdxLayoutItem;
    dbsLocations: TfraDBStrings;
    mdsEventsLocations: TMemoField;
    dbsMoves: TfraDBStrings;
    dbsMarks: TfraDBStrings;
    dbsRibbons: TfraDBStrings;
    mdsEventsMoves: TMemoField;
    mdsEventsMarks: TMemoField;
    mdsEventsRibbons: TMemoField;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbsLocationsChange(Sender: TObject);
    procedure dbsMovesChange(Sender: TObject);
    procedure dbsMarksChange(Sender: TObject);
    procedure dbsRibbonsChange(Sender: TObject);
    procedure mdsEventsNewRecord(DataSet: TDataSet);
    procedure mdsEventsAfterScroll(DataSet: TDataSet);
    procedure actPostUpdate(Sender: TObject);
    procedure mdsEventsBeforePost(DataSet: TDataSet);
    procedure mdsEventsBeforeDelete(DataSet: TDataSet);
    procedure actPostExecute(Sender: TObject);
  private
    { Private declarations }
    FAPI: IPokeventsAPI;
    function GetCurrentEvent: TPokevent;
    procedure StringsChange(FieldName: String; Strings: TStrings);
  public
    { Public declarations }
  end;

var
  frmPEAMain: TfrmPEAMain;

implementation

{$R *.dfm}

uses
  DateUtils, Spring.Container, Spring.Collections, Enum2MDS;

const
  GameField: array[TGame] of String =
    ('Sun', 'Moon', 'UltraSun', 'UltraMoon', 'GO', 'Sword', 'Shield',
     'LetsGoEevee', 'LetsGoPikachu', 'BrilliantDiamond', 'ShiningPearl',
     'LegendsArceus','Home');

function TfrmPEAMain.GetCurrentEvent: TPokevent;
  procedure CollectStrings(FieldName: String; Collection: IList<String>);
  begin
    var Strings: TStrings := TStringList.Create;
    try
      Strings.Text := mdsEvents.FieldByName(FieldName).AsString;
      for var s := 0 to Strings.Count - 1 do
        if not String.IsNullOrWhiteSpace(Strings[s]) then
          Collection.Add(Strings[s].Trim);
    finally
      Strings.Free;
    end;
  end;
begin
  Result.Clear;
  Result.Title := mdsEventsTitle.AsString.Trim;
  Result.Species := mdsEventsSpecies.AsString.Trim;
  Result.Description := mdsEventsDescription.AsString.Trim;
  Result.Kind := mdsEventsKind.AsString.Trim;
  Result.Region := TRegion(mdsEventsRegion.AsInteger);
  if not mdsEventsGender.IsNull then
    Result.Gender := TGender(mdsEventsGender.AsInteger);
  if not mdsEventsBall.IsNull or String.IsNullOrWhiteSpace(mdsEventsBall.AsString) then
    Result.Ball := mdsEventsBall.AsString.Trim;
  if not mdsEventsOT.IsNull or String.IsNullOrWhiteSpace(mdsEventsOT.AsString) then
    Result.OT := mdsEventsOT.AsVariant;
  if not mdsEventsTID.IsNull or String.IsNullOrWhiteSpace(mdsEventsTID.AsString) then
    Result.TID := mdsEventsTID.AsVariant;
  if not mdsEventsAbility.IsNull or String.IsNullOrWhiteSpace(mdsEventsAbility.AsString) then
    Result.Ability := mdsEventsAbility.AsVariant;
  if not mdsEventsHoldItem.IsNull or String.IsNullOrWhiteSpace(mdsEventsHoldItem.AsString) then
    Result.HoldItem := mdsEventsHoldItem.AsVariant;
  if not mdsEventsNature.IsNull or String.IsNullOrWhiteSpace(mdsEventsNature.AsString) then
    Result.Nature := mdsEventsNature.AsVariant;
  if not mdsEventsCode.IsNull or String.IsNullOrWhiteSpace(mdsEventsCode.AsString) then
    Result.Code := mdsEventsCode.AsVariant;
  Result.Level := mdsEventsLevel.AsVariant;
  Result.Shiny := mdsEventsShiny.AsBoolean;
  Result.Gigantamax := mdsEventsGigantamax.AsBoolean;
  Result.StartDate := DateOf(mdsEventsStartDate.AsDateTime);
  if not mdsEventsEndDate.IsNull then
    Result.EndDate := DateOf(mdsEventsEndDate.AsDateTime);

  for var Game := Low(TGame) to High(TGame) do
    if mdsEvents.FieldByName(GameField[Game]).AsBoolean then
      Include(Result.Games, Game);

  CollectStrings('Locations', Result.Locations);
  CollectStrings('Moves', Result.Moves);
  CollectStrings('Marks', Result.Marks);
  CollectStrings('Ribbons', Result.Ribbons);
end;

procedure TfrmPEAMain.actPostExecute(Sender: TObject);
begin
  mdsEvents.Post;
end;

procedure TfrmPEAMain.actPostUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := (mdsEvents.State in [dsInsert,dsEdit]);
end;

procedure TfrmPEAMain.dbsLocationsChange(Sender: TObject);
begin
  StringsChange('Locations', TfraDBStrings(Sender).Strings);
end;

procedure TfrmPEAMain.dbsMarksChange(Sender: TObject);
begin
  StringsChange('Marks', TfraDBStrings(Sender).Strings);
end;

procedure TfrmPEAMain.dbsMovesChange(Sender: TObject);
begin
  StringsChange('Moves', TfraDBStrings(Sender).Strings);
end;

procedure TfrmPEAMain.dbsRibbonsChange(Sender: TObject);
begin
  StringsChange('Ribbons', TfraDBStrings(Sender).Strings);
end;

procedure TfrmPEAMain.FormCreate(Sender: TObject);
begin
  FAPI := GlobalContainer.Resolve<IPokeventsAPI>;
  dtsRegion.DataSet := TEnum2MDS<TRegion>.CreateMemData(dtsRegion, RegionName);
  dtsGender.DataSet := TEnum2MDS<TGender>.CreateMemData(dtsGender, GenderName);

  dbsLocations.ValueName := 'Location';
  dbsLocations.OnChange := dbsLocationsChange;

  dbsMoves.ValueName := 'Move';
  dbsMoves.OnChange := dbsMovesChange;
  dbsMoves.MaxLines := 4;

  dbsMarks.ValueName := 'Mark';
  dbsMarks.OnChange := dbsMarksChange;

  dbsRibbons.ValueName := 'Ribbon';
  dbsRibbons.OnChange := dbsRibbonsChange;
end;

procedure TfrmPEAMain.FormShow(Sender: TObject);
  procedure ExtractStrings(Field: String; Collection: IList<String>; Frame: TfraDBStrings);
  begin
    var Strings: TStrings := TStringList.Create;
    try
      for var Item in Collection do
        Strings.Add(Item);
      mdsEvents.FieldByName(Field).AsString := Strings.Text;
      Frame.Strings.SetStrings(Strings);
    finally
      Strings.Free;
    end;
  end;
begin
  mdsEvents.Open;

  mdsEvents.BeforePost := nil;
  mdsEvents.BeforeScroll := nil;
  try
    var Events := FAPI.GetEvents;
    for var ID in Events.Keys do
    begin
      mdsEvents.Append;
      mdsEventsAWSID.AsString := ID;
      mdsEventsTitle.AsString := Events[ID].Title;
      mdsEventsSpecies.AsString := Events[ID].Species;
      mdsEventsDescription.AsString := Events[ID].Description;
      mdsEventsKind.AsString := Events[ID].Kind;
      mdsEventsRegion.AsInteger := Ord(Events[ID].Region);
      if Events[ID].Gender.HasValue then
        mdsEventsGender.AsInteger := Ord(Events[ID].Gender.Value);
      mdsEventsBall.AsVariant := Events[ID].Ball;
      mdsEventsOT.AsVariant := Events[ID].OT;
      mdsEventsTID.AsVariant := Events[ID].TID;
      mdsEventsAbility.AsVariant := Events[ID].Ability;
      mdsEventsNature.AsVariant := Events[ID].Nature;
      mdsEventsCode.AsVariant := Events[ID].Code;
      mdsEventsHoldItem.AsVariant := Events[ID].HoldItem;
      mdsEventsLevel.AsVariant := Events[ID].Level;
      mdsEventsShiny.AsBoolean := Events[ID].Shiny;
      mdsEventsGigantamax.AsBoolean := Events[ID].Gigantamax;
      mdsEventsStartDate.AsDateTime := Events[ID].StartDate;
      mdsEventsEndDate.AsVariant := Events[ID].EndDate;
      mdsEventsSun.AsBoolean := gaSun in Events[ID].Games;
      mdsEventsMoon.AsBoolean := gaMoon in Events[ID].Games;
      mdsEventsUltraSun.AsBoolean := gaUltraSun in Events[ID].Games;
      mdsEventsUltraMoon.AsBoolean := gaUltraMoon in Events[ID].Games;
      mdsEventsGO.AsBoolean := gaGO in Events[ID].Games;
      mdsEventsSword.AsBoolean := gaSword in Events[ID].Games;
      mdsEventsShield.AsBoolean := gaShield in Events[ID].Games;
      mdsEventsLetsGoEevee.AsBoolean := gaLetsGoEevee in Events[ID].Games;
      mdsEventsLetsGoPikachu.AsBoolean := gaLetsGoPikachu in Events[ID].Games;
      mdsEventsBrilliantDiamond.AsBoolean := gaBrilliantDiamond in Events[ID].Games;
      mdsEventsShiningPearl.AsBoolean := gaShiningPearl in Events[ID].Games;
      mdsEventsLegendsArceus.AsBoolean := gaPLA in Events[ID].Games;
      mdsEventsHome.AsBoolean := gaHome in Events[ID].Games;

      ExtractStrings('Locations', Events[ID].Locations, dbsLocations);
      ExtractStrings('Moves', Events[ID].Moves, dbsMoves);
      ExtractStrings('Marks', Events[ID].Marks, dbsMarks);
      ExtractStrings('Ribbons', Events[ID].Ribbons, dbsRibbons);

      mdsEvents.Post;
    end;
  finally
    mdsEvents.BeforePost := mdsEventsBeforePost;
  end;
end;

procedure TfrmPEAMain.mdsEventsAfterScroll(DataSet: TDataSet);
begin
  dbsLocations.Strings.Text := mdsEventsLocations.AsString;
  dbsMoves.Strings.Text := mdsEventsMoves.AsString;
  dbsMarks.Strings.Text := mdsEventsMarks.AsString;
  dbsRibbons.Strings.Text := mdsEventsRibbons.AsString;
end;

procedure TfrmPEAMain.mdsEventsBeforeDelete(DataSet: TDataSet);
begin
  if not mdsEventsAWSID.AsString.IsEmpty then
    FAPI.DeleteEvent(mdsEventsAWSID.AsString);
end;

procedure TfrmPEAMain.mdsEventsBeforePost(DataSet: TDataSet);
begin
  var Pokevent := GetCurrentEvent;

  Pokevent.Validate;

  if mdsEventsAWSID.AsString.IsEmpty then
    mdsEventsAWSID.AsString := FAPI.CreateEvent(Pokevent)
  else
    FAPI.UpdateEvent(mdsEventsAWSID.AsString, Pokevent);
end;

procedure TfrmPEAMain.mdsEventsNewRecord(DataSet: TDataSet);
begin
  mdsEventsRegion.AsInteger := Ord(reWorldwide);
  mdsEventsShiny.AsBoolean := False;
  mdsEventsGigantamax.AsBoolean := False;
  mdsEventsSun.AsBoolean := False;
  mdsEventsMoon.AsBoolean := False;
  mdsEventsUltraSun.AsBoolean := False;
  mdsEventsUltraMoon.AsBoolean := False;
  mdsEventsGO.AsBoolean := False;
  mdsEventsSword.AsBoolean := False;
  mdsEventsShield.AsBoolean := False;
  mdsEventsLetsGoEevee.AsBoolean := False;
  mdsEventsLetsGoPikachu.AsBoolean := False;
  mdsEventsBrilliantDiamond.AsBoolean := False;
  mdsEventsShiningPearl.AsBoolean := False;
  mdsEventsLegendsArceus.AsBoolean := False;
  mdsEventsHome.AsBoolean := False;
end;

procedure TfrmPEAMain.StringsChange(FieldName: String; Strings: TStrings);
begin
  if not (mdsEvents.State in [dsInsert,dsEdit]) then
    mdsEvents.Edit;
  mdsEvents.FieldByName(FieldName).AsString := Strings.Text;
end;

end.
