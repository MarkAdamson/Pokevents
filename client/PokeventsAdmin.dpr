program PokeventsAdmin;

uses
  Vcl.Forms,
  Spring.Container,
  PEAMain in 'PEAMain.pas' {frmPEAMain},
  PEATypes in 'PEATypes.pas',
  Enum2MDS in 'Enum2MDS.pas',
  SimpleGenericEnum in 'SimpleGenericEnum.pas',
  DMObject in 'DMObject.pas',
  VirtualObject in 'VirtualObject.pas',
  PEAService in 'PEAService.pas' {dmPEAService: TDataModule},
  DBStringsFrame in 'DBStringsFrame.pas' {fraDBStrings: TFrame};

{$R *.res}

begin
  GlobalContainer.Build;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPEAMain, frmPEAMain);
  Application.Run;
end.
