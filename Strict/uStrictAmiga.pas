unit uStrictAmiga;

interface

type
  TCachorro = class
	private
    FVarPrivada: Integer;
		FIdade: Byte;
    FPeso: Byte;
    FRaca: string;
    FCaracteristica: string;
  //strict private
    //FVarPrivada: Integer;
  protected
    FVarProtegida: string;
	public
		property Raca: string read FRaca write FRaca;
		property Idade: Byte read FIdade write FIdade;
    [TPesoMaximo(35)]
    property Peso: Byte read FPeso write FPeso;
    property Caracteristica: string read FCaracteristica write FCaracteristica;
    function Late: string;
  end;

  TClasseAmiga = class
  public
    constructor Create;
  end;

implementation

uses
  uStrictPrinc;

{ TClasseAmiga }

constructor TClasseAmiga.Create;
var
  Pinscher: TCachorro;
begin
  Pinscher := TCachorro.Create;
  Pinscher.FVarPrivada := 1111;
  Pinscher.FVarProtegida
end;

{ TCachorro }

function TCachorro.Late: string;
begin
  Result := 'Latido';
end;

end.
