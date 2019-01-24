unit uBreakPointRefactorPrinc;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Datasnap.DBClient;

type
  TBreakPointRefactorPrinc = class(TForm)
    Button1: TButton;
    Button2: TButton;
    cds: TClientDataSet;
    cdsID: TIntegerField;
    cdsNOME: TStringField;
    cdsIDADE: TIntegerField;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  BreakPointRefactorPrinc: TBreakPointRefactorPrinc;

implementation

{$R *.dfm}

procedure TBreakPointRefactorPrinc.Button1Click(Sender: TObject);
var
  lVerificacao: Boolean;
begin
  lVerificacao := 1 = 0;
  if lVerificacao then
    ShowMessage('Sempre tem um jeitinho');
end;

procedure TBreakPointRefactorPrinc.Button2Click(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to 99 do
    begin
    cds.Append;
    cds.FieldByName('ID').Value   := i;
    cds.FieldByName('NOME').Value := Format('PESSOA %d', [i]);
    cds.FieldByName('IDADE').Value:= 30;
    cds.Post;
  end;
end;

end.
