unit uModel;

interface

uses
  System.Contnrs, System.SysUtils, System.Classes, uClasses, uRuntimeTypeInformation;

type
  TModelRTTI = class
  private
    FRTTIInfo: TRuntimeTypeInformation;
    FObjList: TObjectList;
    FPessoa: TPessoa;
    FCachorro: TCachorro;
    FMate: TChimarrao;
  public
    constructor Create;
    destructor Destroy; override;
    function CreateObjs: Integer;
    procedure ReadRTTI(LinesReturn: TStrings);
    property ObjList: TObjectList read FObjList write FObjList;
  end;

implementation

{ TModelRTTI }

constructor TModelRTTI.Create;
begin
  FObjList := TObjectList.Create;
  FRTTIInfo := TRuntimeTypeInformation.Create(FObjList);
end;

function TModelRTTI.CreateObjs: Integer;
begin
  FPessoa := TPessoa.Create;
  FPessoa.Nome := 'Luiz';
  FPessoa.Idade:= 21;
  FObjList.Add(FPessoa);

  FCachorro := TCachorro.Create;
  FCachorro.Raca  := 'Pinscher';
  FCachorro.Idade := 17;
  FCachorro.Peso  := 2;
  FCachorro.Caracteristica := 'Muita Raiva';
  FObjList.Add(FCachorro);

  FMate := TChimarrao.Create;
  FMate.ErvaMate := 'Moída da grossa';
  FMate.Cuia     := 'Porongo';
  FMate.Bomba    := 'Média';
  FMate.Tipo     := 'Tradicional';
  FObjList.Add(FMate);

  Result := 3;
end;

destructor TModelRTTI.Destroy;
begin
  FreeAndNil(FObjList);
  inherited;
end;

procedure TModelRTTI.ReadRTTI(LinesReturn: TStrings);
begin
  FRTTIInfo.GetObjectRTTI(LinesReturn);
end;

end.
