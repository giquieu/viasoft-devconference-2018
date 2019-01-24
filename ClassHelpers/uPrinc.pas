unit uPrinc;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  System.DateUtils, Math, Vcl.Mask;

type
  TPessoa = class
  private
    FDtNascimento: TDate;
  public
    property DtNascimento: TDate read FDtNascimento write FDtNascimento;
  end;

  TPessoaHelper = class helper for TPessoa
  private
    function GetIdade: Integer;
  public
    property Idade: Integer read GetIdade;
  end;

  TIntHelper = record helper for Integer
  public
    function ParaStringIdade:String;
  end;

  TVsDoubleHelper = record helper for Extended
  public
    function Arredondar: Double;
    function TruArr(cIAT: Char): Double;
  end;

  TForm1 = class(TForm)
    btnExemplo1: TButton;
    btnExemplo2: TButton;
    edtEx2: TEdit;
    btnExemplo3: TButton;
    cbEx3: TComboBox;
    procedure btnExemplo1Click(Sender: TObject);
    procedure btnExemplo2Click(Sender: TObject);
    procedure btnExemplo3Click(Sender: TObject);
  private
    Pessoa: TPessoa;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function TIntHelper.ParaStringIdade: String;
var
  fteste: Integer;
begin
  Result := Format('Apenas %d anos!', [Self]);
end;

procedure TForm1.btnExemplo1Click(Sender: TObject);
var
  n: Integer;
begin
  Pessoa := TPessoa.Create;
  try
    Pessoa.DtNascimento := StrToDate('26/11/1988');
    ShowMessage(Pessoa.Idade.ParaStringIdade);
  finally
    Pessoa.Free;
  end;
end;

{ TPessoaHelper }

function TPessoaHelper.GetIdade: integer;
begin
  Result := YearsBetween(Self.DtNascimento,Now);
end;

{ TVsDoubleHelper }

function TVsDoubleHelper.Arredondar: Double;
begin
  Result := Math.SimpleRoundTo(Self, -3);
end;

procedure TForm1.btnExemplo2Click(Sender: TObject);
var
  capivara: Extended;
begin
  capivara := StrtoFloat(edtEx2.Text);
  ShowMessage(capivara.Arredondar.ToString);
end;

procedure TForm1.btnExemplo3Click(Sender: TObject);
begin
  if cbEx3.ItemIndex = 0 then
    ShowMessage(StrToFloat(edtEx2.Text).TruArr('T').ToString)
  else
  if cbEx3.ItemIndex = 1 then
    ShowMessage(StrToFloat(edtEx2.Text).TruArr('A').ToString)
  else
    ShowMessage('Opção inválida');
end;

function TVsDoubleHelper.TruArr(cIAT: Char): Double;
begin
  if (cIAT = 'A') then
    Result := Math.SimpleRoundTo(Self, -3)
  else if (cIAT = 'T') then
    Result := Trunc(Self)
  else
    Result := Self;
end;

end.
