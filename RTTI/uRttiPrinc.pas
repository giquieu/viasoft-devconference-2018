unit uRttiPrinc;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.Rtti, Vcl.ExtCtrls,
  uModel, uRuntimeTypeInformation;

type
  TRTTIPrinc = class(TForm)
    Panel1: TPanel;
    Memo1: TMemo;
    btnCriaObjs: TButton;
    btnReadRTTI: TButton;
    procedure btnCriaObjsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnReadRTTIClick(Sender: TObject);
  private
    FModel: TModelRTTI;
  public
    { Public declarations }
  end;

var
  RTTIPrinc: TRTTIPrinc;

implementation

{$R *.dfm}

procedure TRTTIPrinc.btnCriaObjsClick(Sender: TObject);
var
  nObjs: Integer;
begin
  nObjs := FModel.CreateObjs;
  ShowMessage(Format('Criados %d objetos', [nObjs]));
end;

procedure TRTTIPrinc.btnReadRTTIClick(Sender: TObject);
begin
  Memo1.Lines.Clear;
  FModel.ReadRTTI(Memo1.Lines);
end;

procedure TRTTIPrinc.FormCreate(Sender: TObject);
begin
  FModel := TModelRTTI.Create;
end;

end.
