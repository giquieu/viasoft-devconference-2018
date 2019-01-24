unit uClasses;

interface

type
  TIdadeMinima = class(TCustomAttribute)
	private
		FIdadeMinima: Byte;
	public
		constructor Create(AIdadeMinima: Byte);
		function IsIdadeMaior(AIdade: Byte): Boolean;
		property IdadeMinima: Byte read FIdadeMinima;
  end;

  TPesoMaximo = class(TCustomAttribute)
  private
		FPesoMaximo: Byte;
	public
		constructor Create(PesoMaximo: Byte);
		function IsPesoMenor(APeso: Byte): Boolean;
		property PesoMaximo: Byte read FPesoMaximo;
  end;

  TAudited = class(TCustomAttribute)
  end;

  TPessoa = class
	private
		FNome: string;
		FIdade: Byte;
	public
    [TAudited]
		property Nome: string read FNome write FNome;
		[TIdadeMinima(21)]
		property Idade: Byte read FIdade write FIdade;
    constructor Create;
    destructor Destroy; override;
  end;

  TCachorro = class
	private
		FIdade: Byte;
    FPeso: Byte;
    FRaca: string;
    FCaracteristica: string;
	public
		property Raca: string read FRaca write FRaca;
		property Idade: Byte read FIdade write FIdade;
    [TPesoMaximo(35)]
    property Peso: Byte read FPeso write FPeso;
    property Caracteristica: string read FCaracteristica write FCaracteristica;
    function Late: string;
  end;

  TChimarrao = class
  private
    FBomba: string;
    FErvaMate: string;
    FTipo: string;
    FCuia: string;
  public
    property ErvaMate: string read FErvaMate write FErvaMate;
    property Cuia: string read FCuia write FCuia;
    property Bomba: string read FBomba write FBomba;
    property Tipo: string read FTipo write FTipo;
    function TemperaturaIdeal: Extended;
  end;

implementation

{ TIdadeMinima }

constructor TIdadeMinima.Create(AIdadeMinima: Byte);
begin
  Self.FIdadeMinima := AIdadeMinima;
end;

function TIdadeMinima.IsIdadeMaior(AIdade: Byte): Boolean;
begin
  Result := AIdade >= Self.FIdadeMinima;
end;

{ TPesoMaximo }

constructor TPesoMaximo.Create(PesoMaximo: Byte);
begin
  Self.FPesoMaximo := PesoMaximo;
end;

function TPesoMaximo.IsPesoMenor(APeso: Byte): Boolean;
begin
  Result := APeso <= 100;
end;

{ TCachorro }

function TCachorro.Late: string;
begin
  Result := 'Latido';
end;

{ TPessoa }

constructor TPessoa.Create;
begin
  //
end;

destructor TPessoa.Destroy;
begin
  //
  inherited;
end;

{ TChimarrao }

function TChimarrao.TemperaturaIdeal: Extended;
begin
  Result := 38.5;
end;

end.
