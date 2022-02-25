unit DMObject;

interface

uses
  System.SysUtils, System.Classes;

type
  TDataModule = class (System.Classes.TDataModule)
  public
    constructor Create; reintroduce; virtual;
  end;

  TDMDelegate<TDM: TDataModule, constructor> = class sealed (TInterfacedObject)
  private
    FOwnsDM: Boolean;
    FDM: TDM;
  protected
    function DM: TDM;
  public
    constructor Create; overload;
    constructor Create(ADM: TDM); overload;
    destructor Destroy; override;
  end;

  TDMObject<TDM: TDataModule, constructor> = class (TInterfacedObject)
  private
    FDelegate: TDMDelegate<TDM>;
  protected
    function DM: TDM;
  public
    constructor Create; overload;
    constructor Create(ADM: TDM); overload;
    destructor Destroy; override;
  end;

implementation

{ TDataModule }

constructor TDataModule.Create;
begin
  inherited Create(nil);
end;

{ TDMDelegate<TDM> }

constructor TDMDelegate<TDM>.Create;
begin
  Create(TDM.Create);
  FOwnsDM := True;
end;

constructor TDMDelegate<TDM>.Create(ADM: TDM);
begin
  FDM := ADM;
  FOwnsDM := False;
end;

destructor TDMDelegate<TDM>.Destroy;
begin
  if FOwnsDM then
    FDM.Free;
  inherited;
end;

function TDMDelegate<TDM>.DM: TDM;
begin
  Result := FDM;
end;

{ TDMObject<TDM> }

constructor TDMObject<TDM>.Create;
begin
  FDelegate := TDMDelegate<TDM>.Create;
end;

constructor TDMObject<TDM>.Create(ADM: TDM);
begin
  FDelegate := TDMDelegate<TDM>.Create(ADM);
end;

destructor TDMObject<TDM>.Destroy;
begin
  FDelegate.Free;
  inherited;
end;

function TDMObject<TDM>.DM: TDM;
begin
  Result := FDelegate.DM;
end;

end.
