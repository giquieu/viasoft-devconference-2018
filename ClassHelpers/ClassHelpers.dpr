program ClassHelpers;

uses
  Vcl.Forms,
  uPrinc in 'uPrinc.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
