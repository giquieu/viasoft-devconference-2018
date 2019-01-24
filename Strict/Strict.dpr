program Strict;

uses
  Vcl.Forms,
  uStrictPrinc in 'uStrictPrinc.pas' {StrictPrinc},
  uStrictAmiga in 'uStrictAmiga.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TStrictPrinc, StrictPrinc);
  Application.Run;
end.
