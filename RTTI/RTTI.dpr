program RTTI;

uses
  Vcl.Forms,
  uRttiPrinc in 'uRttiPrinc.pas' {RTTIPrinc},
  uClasses in 'uClasses.pas',
  uRuntimeTypeInformation in 'uRuntimeTypeInformation.pas',
  uModel in 'uModel.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TRTTIPrinc, RTTIPrinc);
  Application.Run;
end.
