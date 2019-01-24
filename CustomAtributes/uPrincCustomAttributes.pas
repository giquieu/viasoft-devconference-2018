unit uPrincCustomAttributes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.Rtti;

type
  TIdadeMinima= class(TCustomAttribute)
	private
		FIdadeMinima: Byte;
	public
		constructor Create(AIdadeMinima: Byte);
		function IsIdadeMaior(AIdade: Byte): Boolean;
		property IdadeMinima: Byte read FIdadeMinima;
end;

  TPessoa = class
	private
		FNome: string;
		FIdade: Byte;
	public
		property Nome: string read FNome write FNome;
		[TIdadeMinima(18)]
		property Idade: Byte read FIdade write FIdade;
end;

  TForm2 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    procedure Valida(Pessoa: TPessoa);
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
var
  PessTeste: TPessoa;
begin
  PessTeste := TPessoa.Create;
  PessTeste.Nome := 'Luiz';
  PessTeste.Idade:= 17;
  try
    Valida(PessTeste);
  finally
    FreeAndNil(PessTeste);
  end;
end;

procedure TForm2.Button2Click(Sender: TObject);
var
  PessTeste: TPessoa;
begin
  PessTeste := TPessoa.Create;
  PessTeste.Nome := 'Juca';
  PessTeste.Idade:= 29;
  try
    Valida(PessTeste);
  finally
    FreeAndNil(PessTeste);
  end;
end;

procedure TForm2.Valida(Pessoa: TPessoa);
var
  _ctx: TRttiContext;
  _typ: TRttiType;
  _pro: TRttiProperty;
  oAtt: TCustomAttribute;
begin
  _ctx := TRttiContext.Create;
  _typ := _ctx.GetType(Pessoa.ClassType);
  for _pro in _typ.GetProperties do
    begin
    for oAtt in _pro.GetAttributes do
      begin
      if oAtt is TIdadeMinima then
        begin
        ShowMessage(Format('A idade mínima é de: %d', [TIdadeMinima(oAtt).IdadeMinima]));
        if (TIdadeMinima(oAtt).IsIdadeMaior(Pessoa.Idade)) then
          ShowMessage(Format('A idade de %s passou!', [Pessoa.Nome]))
        else
          ShowMessage(Format('A idade de %s não passou!', [Pessoa.Nome]))
      end;
    end;
  end;
end;

{ TIdadeMinima }

constructor TIdadeMinima.Create(AIdadeMinima: Byte);
begin
  Self.FIdadeMinima := AIdadeMinima;
end;

function TIdadeMinima.IsIdadeMaior(AIdade: Byte): Boolean;
begin
  Result := AIdade >= Self.FIdadeMinima;
end;

end.
