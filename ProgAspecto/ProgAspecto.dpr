program ProgAspecto;

uses
  Vcl.Forms,
  uProgAspecPrinc in 'uProgAspecPrinc.pas' {Form1},
  uRoedor in 'uRoedor.pas',
  uCustomAttImpl in 'uCustomAttImpl.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
