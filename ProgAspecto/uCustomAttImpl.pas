unit uCustomAttImpl;

interface

uses
  System.SysUtils;

type
  Audit = class(TCustomAttribute)
  public
    procedure AuditSave(cFile, cLog: string);
  end;

implementation

{ Audit }

procedure Audit.AuditSave(cFile, cLog: string);
var
  txtFile: TextFile;
begin
  AssignFile(txtFile, cFile);
  try
    Append(txtFile);
    Writeln(txtFile, cLog);
  finally
    CloseFile(txtFile);
  end;
end;

end.
