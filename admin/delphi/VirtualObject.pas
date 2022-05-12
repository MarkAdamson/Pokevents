unit VirtualObject;

interface

uses
  System.SysUtils, System.Classes, Rtti, TypInfo, Windows, DMObject,
  Spring.Container;

type
  TDataModule = class (DMObject.TDataModule);

  TVirtualObject<TDM: TDataModule, constructor; I: IInvokable> = class (TVirtualInterface)
  private
    FType: TRttiType;
    FDMDelegate: TDMDelegate<TDM>;
    class var FInterfaceTable: PInterfaceTable;
  protected
    constructor _Create; virtual;
    function DM: TDM;
  public
    class function Create: I;
    function GetSelf: I;
    procedure DoInvoke(Method: TRttiMethod; const Args: TArray<TValue>; out Result: TValue);
    class procedure Register(Container: TContainer; const ServiceName: String = '');
    destructor Destroy; override;
    class destructor Destroy;
  end;

implementation

{ TVirtualObject<TDM, I> }

constructor TVirtualObject<TDM, I>._Create;
begin
  inherited Create(TypeInfo(I), DoInvoke);
  FDMDelegate := TDMDelegate<TDM>.Create;

  with TRttiContext.Create do
  try
    FType := GetType(TDM);
  finally
    Free;
  end;
end;

destructor TVirtualObject<TDM, I>.Destroy;
begin
  FDMDelegate.Free;
  inherited;
end;

class function TVirtualObject<TDM, I>.Create: I;
begin
  Result := _Create.GetSelf;
end;

class destructor TVirtualObject<TDM, I>.Destroy;
begin
  Dispose(FInterfaceTable);
end;

function TVirtualObject<TDM, I>.DM: TDM;
begin
  Result := FDMDelegate.DM;
end;

procedure TVirtualObject<TDM, I>.DoInvoke(Method: TRttiMethod;
  const Args: TArray<TValue>; out Result: TValue);
begin
  Result := Ftype.GetMethod(Method.Name).Invoke(DM, Copy(Args, 1, Length(Args) - 1));
end;

function TVirtualObject<TDM, I>.GetSelf: I;
begin
  QueryInterface(GetTypeData(TypeInfo(I))^.Guid, Result);
end;

class procedure TVirtualObject<TDM, I>.Register(Container: TContainer;
  const ServiceName: String);
begin
  Container.RegisterType<I>(ServiceName).DelegateTo(
    function: I
    begin
      Result := Create;
    end);
end;

end.
