unit DBStringsFrame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, cxControls, cxContainer,
  cxEdit, cxCustomListBox, cxListBox, cxDBEdit, Vcl.StdCtrls, cxButtons,
  Vcl.ExtCtrls, Data.DB, System.Actions, Vcl.ActnList, Vcl.DBCtrls, cxTextEdit,
  cxMemo;

type
  TfraDBStrings = class(TFrame)
    gpButtons: TGridPanel;
    btnAdd: TcxButton;
    btnEdit: TcxButton;
    btnDelete: TcxButton;
    Actions: TActionList;
    actAdd: TAction;
    actEdit: TAction;
    actDelete: TAction;
    lbStrings: TcxListBox;
    procedure actAddUpdate(Sender: TObject);
    procedure actAddExecute(Sender: TObject);
    procedure actEditUpdate(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
  private
    { Private declarations }
    FOnChange: TNotifyEvent;
    FMaxLines: Integer;
    FValueName: String;
    function GetStrings: TStrings;
  public
    { Public declarations }
    property Strings: TStrings read GetStrings;
    property OnChange: TNotifyEvent read FOnChange write FOnchange;
    property MaxLines: Integer read FMaxLines write FMaxLines;
    property ValueName: String read FValueName write FValueName;
  end;

implementation

{$R *.dfm}

{ TfraDBStrings }

procedure TfraDBStrings.actAddExecute(Sender: TObject);
var
  Value: String;
begin
  Value := '';
  while String.IsNullOrWhiteSpace(Value) do
    if not InputQuery(Format('Enter %s...', [ValueName]), ValueName, Value) then
      Exit;
  Strings.Add(Value.Trim);

  if Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure TfraDBStrings.actAddUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := (MaxLines <= 0) or (Strings.Count < MaxLines);
end;

procedure TfraDBStrings.actDeleteExecute(Sender: TObject);
begin
  for var i := 0 to Strings.Count - 1 do
    if lbStrings.Selected[i] then
    begin
      Strings.Delete(i);

      if Assigned(FOnChange) then
        FOnChange(Self);

      Exit;
    end;
end;

procedure TfraDBStrings.actEditExecute(Sender: TObject);
begin
  for var i := 0 to Strings.Count - 1 do
    if lbStrings.Selected[i] then
    begin
      var Value := Strings[i];
      repeat
        if not InputQuery(Format('Edit %s...', [ValueName]), ValueName, Value) then
          Exit;
      until not String.IsNullOrWhiteSpace(Value);

      if SameStr(Value, Strings[i]) then
        Exit;

      Strings[i] := Value.Trim;

      if Assigned(FOnChange) then
        FOnChange(Self);

      Exit;
    end;
end;

procedure TfraDBStrings.actEditUpdate(Sender: TObject);
begin
  for var i := 0 to Strings.Count - 1 do
    if lbStrings.Selected[i] then
    begin
      TAction(Sender).Enabled := True;
      Exit;
    end;

  TAction(Sender).Enabled := False;
end;

function TfraDBStrings.GetStrings: TStrings;
begin
  Result := lbStrings.Items;
end;

end.
