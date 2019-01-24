program BreakPointERefactor;

uses
  Vcl.Forms,
  uBreakPointRefactorPrinc in 'uBreakPointRefactorPrinc.pas' {BreakPointRefactorPrinc};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TBreakPointRefactorPrinc, BreakPointRefactorPrinc);
  Application.Run;
end.
