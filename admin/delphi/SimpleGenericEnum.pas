unit SimpleGenericEnum;

interface
uses SysUtils,TypInfo;
type
  TEnum<T> = record
  type
    EEnum= class(Exception)
      constructor CreateFmt(const Test: String; const Args: array of Const);
    end;
  public
    Value:T;
    class var _TypeData: pTypeData;
    class function High: T; static;
    class function Low: T; static;
    class function GetTypeData: pTypeData; inline; static;{Inline working is a wish really}
    class operator Implicit(aValue: Integer): TEnum<T>;
    class operator Implicit(aValue: TEnum<T>): Integer;
    class operator Implicit(aValue: T): TEnum<T>;
    class operator Implicit(aValue: TEnum<T>): T;
    class operator Implicit(const aValue: String): TEnum<T>;
    class operator Implicit(aValue: TEnum<T>): String;
    class function GetEnumValue(const Name: String): Integer; inline; static;
    class function GetEnumName(Index: Integer): String; overload; inline; static;
    class function GetEnumName(Index: T): String; overload;inline; static;
    class function GetEnumNames : TArray<string>; static;
    class function GetEnumStrings : TArray<string>; static;
    class function Ord(Value:T): Integer; inline; static;{Inline working is a wish really}
    class function Cast(Value:Integer): T; inline; static; {Inline working is a wish really}
    function ToString: String;
    function StringTo(const AValue: String): Boolean;
  public
    // These function determine the default format of the strings
    // Currenlty they remove the lower case prefix and convert '_' to ' ' and vice verse
    class function EnumToStr(Value: T): String; static;
    class function StrToEnum(Name: String; out Value: T): Boolean; static;
  end;

implementation
{ TEnum<T> }


class operator TEnum<T>.Implicit(aValue: TEnum<T>): T;
begin
  Result := aValue.Value;
end;

class operator TEnum<T>.Implicit(aValue: T): TEnum<T>;
begin
  Result.Value := aValue;
end;

class operator TEnum<T>.Implicit(const aValue: String): TEnum<T>;
begin
  if not Result.StringTo(aValue) then
    raise EEnum.CreateFmt('"%s" is not a valid name',[aValue]);
end;

class function TEnum<T>.Cast(Value: Integer): T;
begin
  if (Value < GetTypeData.MinValue) then
    raise EEnum.CreateFmt('%d is below min value [%d]',[Value,GetTypeData.MinValue])
  else if (Value > GetTypeData.MaxValue) then
    raise EEnum.CreateFmt('%d is above max value [%d]',[Value,GetTypeData.MaxValue]);
  case Sizeof(T) of
    1: pByte(@Result)^ := Value;
    2: pWord(@Result)^ := Value;
    4: pCardinal(@Result)^ := Value;
  end;
end;

class function TEnum<T>.GetEnumName(Index: Integer): String;
begin
  Result := TypInfo.GetEnumName(TypeInfo(T),Index);
end;


class function TEnum<T>.GetEnumName(Index: T): String;
begin
  Result := GetEnumName(Ord(Index));
end;

class function TEnum<T>.GetEnumNames: TArray<string>;
var
  p: PTypeData;
  i: Integer;
  s: String;
  pt: PTypeInfo;
begin
  pt := TypeInfo(T);
  p := GetTypeData;
  SetLength(Result, p.MaxValue+1);
  for i := p.MinValue to p.MaxValue do
  begin
    S := GetEnumName(i);
    Result[i] := S;
  end;
end;

class function TEnum<T>.GetEnumStrings: TArray<string>;
var
  p: PTypeData;
  i: Integer;
  s: String;
  pt: PTypeInfo;
begin
  pt := TypeInfo(T);
  p := GetTypeData;
  SetLength(Result, p.MaxValue+1);
  for i := p.MinValue to p.MaxValue do
  begin
    S := TEnum<T>(i).ToString;
    Result[i] := S;
  end;
end;

class function TEnum<T>.GetEnumValue(const Name: String): Integer;
begin
  Result := TypInfo.GetEnumValue(TypeInfo(T),Name);
end;


class function TEnum<T>.GetTypeData: pTypeData;
begin
  if not Assigned(_TypeData) then
    _TypeData := TypInfo.GetTypeData(TypeInfo(T));
  Result := _TypeData;
end;

class function TEnum<T>.High: T;
begin
  Result := Cast(_TypeData.MaxValue);
end;

class operator TEnum<T>.Implicit(aValue: TEnum<T>): String;
begin
  Result := aValue.ToString;
end;

class function TEnum<T>.Low: T;
begin
  Result := Cast(_TypeData.MinValue);
end;

class operator TEnum<T>.Implicit(aValue: Integer): TEnum<T>;
begin
  Result.Value := Cast(aValue);
end;

class operator TEnum<T>.Implicit(aValue: TEnum<T>): Integer;
begin
  Result := Ord(aValue.Value);
end;

class function TEnum<T>.Ord(Value: T): Integer;
begin
  case Sizeof(T) of
    1: Result := pByte(@Value)^;
    2: Result := pWord(@Value)^;
    4: Result := pCardinal(@Value)^;
  end;
end;

function TEnum<T>.StringTo(const AValue: String): Boolean;
begin
  Result := StrToEnum(AValue,Value);
end;

class function TEnum<T>.StrToEnum(Name: String; out Value: T): Boolean;
var
  Temp: String;
  Index: Integer;
begin
  Index := GetEnumValue(Name);
  if Index < 0 then begin
    Temp := GetEnumName(Ord(Low));
    Index := 0;
    while (Index < Length(Temp)) and (Temp[Index+1] in ['a'..'z']) do
      Inc(Index);
    SetLength(Temp,Index);
    Temp := Temp+Name;
    Index := 1;
    while (Index <= Length(Temp)) do begin
      if (Temp[Index] = ' ')  then
        Temp[Index] := '_';
      Inc(Index);
    end;
    Index := GetEnumValue(Temp);
  end;
  Result := Index >= 0;
  if Result then
    Value := Cast(Index);
end;

class function TEnum<T>.EnumToStr(Value: T): String;
var Index: Integer;
begin
  Result := GetEnumName(Value);
  while (Length(Result) > 0) and (Result[1] in ['a'..'z']) do
    Delete(Result,1,1);
  for Index := 1 to Length(Result) do
    if Result[Index] = '_' then
      Result[Index] := ' ';
end;

function TEnum<T>.ToString: String;
begin
  Result := EnumToStr(Value);
end;

{ TEnum<T>.EEnum }

constructor TEnum<T>.EEnum.CreateFmt(const Test: String;
  const Args: array of Const);
var
  Info: pTypeInfo;
begin
  Info := TypeInfo(T);
  inherited CreateFmt('TEnum<%s>:%s',[Info.Name,Format(Test,Args)]);
end;

end.

