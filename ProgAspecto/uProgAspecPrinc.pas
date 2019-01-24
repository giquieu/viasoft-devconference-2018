unit uProgAspecPrinc;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids,
  Data.DB, Datasnap.DBClient, Vcl.DBGrids, System.Rtti, uRoedor, System.Contnrs;

type
  TForm1 = class(TForm)
    pnl1: TPanel;
    ebAltura: TLabeledEdit;
    ebComprimento: TLabeledEdit;
    cbbRoedor: TComboBox;
    lbl1: TLabel;
    btnAdd: TButton;
    dbGrid: TDBGrid;
    ds: TDataSource;
    ebPeso: TLabeledEdit;
    btnEdit: TButton;
    cds: TClientDataSet;
    IntegerField1: TIntegerField;
    StringField1: TStringField;
    FloatField1: TFloatField;
    FloatField2: TFloatField;
    FloatField3: TFloatField;
    procedure btnAddClick(Sender: TObject);
    procedure dbGridCellClick(Column: TColumn);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
  private
    i: Integer;
    RoedorList: TObjectList;
    lTeste2: Boolean;
    function RoedorCreate: TRoedor;
    function RoedorGet: TRoedor;
    procedure VMIRegister(VMI: TVirtualMethodInterceptor; FClass: TRoedor);
    procedure ExtractedMethod(Roedor: TRoedor);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

const
  FilePath = 'd:\ProgAspectExemplo.txt';

implementation

uses
  uCustomAttImpl;

{$R *.dfm}

procedure TForm1.btnAddClick(Sender: TObject);
var
  Roedor: TRoedor;
begin
  Roedor := RoedorCreate;
  Roedor.Tipo        := cbbRoedor.Text;
  Roedor.Peso        := StrToFloat(ebPeso.Text);
  Roedor.Altura      := StrToFloat(ebAltura.Text);
  Roedor.Comprimento := StrToFloat(ebComprimento.Text);
  ExtractedMethod(Roedor);
  RoedorList.Add(Roedor);
end;

procedure TForm1.btnEditClick(Sender: TObject);
var
  TesteTipo: string;
  Roedor: TRoedor;
begin
  Roedor := RoedorGet;
  if Assigned(Roedor) then
  begin
    Roedor.Tipo := cbbRoedor.Text;
    Roedor.Peso := StrToFloat(ebPeso.Text);
    Roedor.Altura := StrToFloat(ebAltura.Text);
    Roedor.Comprimento := StrToFloat(ebComprimento.Text);
    Roedor.Post;
  end;
end;

procedure TForm1.dbGridCellClick(Column: TColumn);
begin
  if cds.RecordCount = 0 then
    Exit;
  cbbRoedor.ItemIndex := cbbRoedor.Items.IndexOf(cds.FieldByName('ROEDOR').Value);
  ebPeso.Text   := cds.FieldbyName('PESO').Value;
  ebAltura.Text := cds.FieldbyName('ALTURA').Value;
  ebComprimento.Text := cds.FieldbyName('COMPRIMENTO').Value;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  RoedorList := TObjectList.Create;
  i := 0;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  RoedorList.Free;
end;

function TForm1.RoedorCreate: TRoedor;
var
  ClassVMI: TVirtualMethodInterceptor;
begin
  Result := TRoedor.CreateAltered(cds);
  Inc(i);
  Result.Id:= i;
  ClassVMI := TVirtualMethodInterceptor.Create(Result.ClassType);
  VMIRegister(ClassVMI, Result);
end;

function TForm1.RoedorGet: TRoedor;
var
  j: Integer;
begin
  for j := 0 to RoedorList.Count-1 do
    begin
    if TRoedor(RoedorList.Items[j]).Id = cds.FieldByName('ID').Value then
      begin
      Result := TRoedor(RoedorList.Items[j]);
      Break;
    end;
  end;
end;

procedure TForm1.VMIRegister(VMI: TVirtualMethodInterceptor; FClass: TRoedor);
begin
  VMI.OnBefore := procedure(Instance: TObject; Method: TRttiMethod;
      const Args: TArray<TValue>; out DoInvoke: Boolean; out Result: TValue)
    var
      lAttribute: TCustomAttribute;
    begin
      for lAttribute in Method.GetAttributes do
        if lAttribute is Audit then
          Audit(lAttribute).AuditSave(FilePath, Format('%s - %n - %n - %n',
            [FClass.Tipo, FClass.Peso, FClass.Altura, FClass.Comprimento]));
    end;
  VMI.Proxify(FClass);
end;

procedure TForm1.ExtractedMethod(Roedor: TRoedor);
begin
  Roedor.Post;
end;

end.
