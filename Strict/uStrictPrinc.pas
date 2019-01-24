unit uStrictPrinc;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TStrictPrinc = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  StrictPrinc: TStrictPrinc;

implementation

uses
  uStrictAmiga;

{$R *.dfm}

procedure TStrictPrinc.FormCreate(Sender: TObject);
var
  Cachorro: TCachorro;
begin
  //Cachorro.FVarPrivada := 10;
end;

end.
