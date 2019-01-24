unit uRoedor;

interface

uses
  System.SysUtils, DBClient, uCustomAttImpl;

type
  TRoedor = class
    [Audit]
    procedure Post; virtual;
  private
    FCds: TClientDataSet;
    FPeso: Extended;
    FAltura: Extended;
    FComprimento: Extended;
    FTipo: string;
    FId: Integer;
  public
    constructor CreateAltered(cds: TClientDataSet);
    property Id: Integer read FId write FId;
    property Tipo: string read FTipo write FTipo;
    property Peso: Extended read FPeso write FPeso;
    property Altura: Extended read FAltura write FAltura;
    property Comprimento: Extended read FComprimento write FComprimento;
  end;

implementation

{ TRoedor }

constructor TRoedor.CreateAltered(cds: TClientDataSet);
begin
  FCds := cds;
end;

procedure TRoedor.Post;
begin
  if Fcds.Locate('ID', Self.Id, []) then
    FCds.Edit
  else
    begin
    FCds.Append;
    FCds.FieldByName('ID').Value    := Self.Id;
  end;
  FCds.FieldByName('ROEDOR').Value      := Self.Tipo;
  FCds.FieldByName('PESO').Value        := Self.Peso;
  FCds.FieldByName('ALTURA').Value      := Self.Altura;
  FCds.FieldByName('COMPRIMENTO').Value := Self.Comprimento;
  FCds.Post;
end;

end.
