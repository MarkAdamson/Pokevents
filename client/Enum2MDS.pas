unit Enum2MDS;

interface

uses
  Classes, Data.DB;

type
  TEnum2MDS<T> = record
  private
    class function CreateNewMemData(AOwner: TComponent): TDataSet; static;
  public
    class function CreateMemData(AOwner: TComponent): TDataSet; overload; static;
    class function CreateMemData(AOwner: TComponent; AStrings: array of String): TDataSet; overload; static;
    class procedure PopulateMemData(AMemData: TDataSet); overload; static;
    class procedure PopulateMemData(AMemData: TDataSet; AStrings: array of String); overload; static;
  end;

implementation

uses
  SimpleGenericEnum, dxmdaset, SysUtils;

{ TEnum2MDS<T> }

class function TEnum2MDS<T>.CreateMemData(AOwner: TComponent): TDataSet;
begin
  Result := CreateNewMemData(AOwner);
  PopulateMemData(Result);
end;

class function TEnum2MDS<T>.CreateMemData(AOwner: TComponent;
  AStrings: array of String): TDataSet;
begin
  Result := CreateNewMemData(AOwner);
  PopulateMemData(Result, AStrings);
end;

class function TEnum2MDS<T>.CreateNewMemData(AOwner: TComponent): TDataSet;
begin
  Result := TdxMemData.Create(AOwner);

  with TIntegerField.Create(Result) do
  begin
    FieldName := 'Index';
    DataSet := Result;
  end;

  with TStringField.Create(Result) do
  begin
    FieldName := 'Name';
    Size := 30; //Really should make this autosize... cba lol
    DataSet := Result;
  end;
end;

class procedure TEnum2MDS<T>.PopulateMemData(AMemData: TDataSet;
  AStrings: array of String);
var
  i, m: Integer;
begin
  m := 0;
  if AMemData is TdxMemData then
    Inc(m);

  if AMemData.FieldCount <> (2 + m) then
    raise Exception.Create('Memory dataset must contain 2 fields');

  if AMemData.Fields[m].DataType <> ftInteger then
    raise Exception.Create('First field must be Integer type');

  if AMemData.Fields[m + 1].DataType <> ftString then
    raise Exception.Create('Second field must be String type');

  AMemData.Close;
  AMemData.Open;

  for i := Low(AStrings) to High(AStrings) do
  begin
    AMemData.Append;
    AMemData.Fields[m].AsInteger := i;
    AMemData.Fields[m + 1].AsString := AStrings[i];
    AMemData.Post;
  end;
end;

class procedure TEnum2MDS<T>.PopulateMemData(AMemData: TDataSet);
begin
  PopulateMemData(AMemData, TEnum<T>.GetEnumStrings);
end;

end.
