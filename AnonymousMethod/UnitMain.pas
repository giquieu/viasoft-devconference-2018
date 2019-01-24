unit UnitMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Datasnap.DBClient;

type

  // TProc = reference to procedure; > System.SysUtils

  TClientDataSetHelper = class Helper for TClientDataSet
    procedure Loop(AAnonymousMethod: TProc);
  end;

  TFormMain = class(TForm)
    Loop: TButton;
    ButtonAnonymous: TButton;
    MemoLoop: TMemo;
    MemoAnonymous: TMemo;
    ClientDataSet: TClientDataSet;
    procedure FormCreate(Sender: TObject);
    procedure LoopClick(Sender: TObject);
    procedure ButtonAnonymousClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

procedure TFormMain.FormCreate(Sender: TObject);
begin
  FormatSettings.CurrencyFormat := 2;

  if FileExists('../../employee.cds') then
    ClientDataSet.LoadFromFile('../../employee.cds');

  if (not (ClientDataSet.Active)) and FileExists('employee.cds') then
    ClientDataSet.LoadFromFile('employee.cds');
end;

procedure TFormMain.LoopClick(Sender: TObject);
begin
  MemoLoop.Clear;
  if ClientDataSet.Active then
  begin
    ClientDataSet.DisableControls;
    ClientDataSet.First;
    while (not ClientDataSet.Eof) do
    begin
      MemoLoop.Lines.Add(
        Format('%S, %S %S', [
          ClientDataSet.FieldByName('LastName').AsString, ClientDataSet.FieldByName('FirstName').AsString,
          CurrToStrF(ClientDataSet.FieldByName('Salary').AsCurrency, ffCurrency, 0, FormatSettings)
        ])
      );
      ClientDataSet.Next;
    end;
    ClientDataSet.EnableControls;
  end;
end;

{ TClientDataSetHelper }

procedure TClientDataSetHelper.Loop(AAnonymousMethod: TProc);
begin
  if Active then
  begin
    DisableControls;
    First;
    while (not Eof) do
    begin
      AAnonymousMethod;
      Next;
    end;
    EnableControls;
  end;
end;

procedure TFormMain.ButtonAnonymousClick(Sender: TObject);
begin
  MemoAnonymous.Clear;
  ClientDataSet.Loop(procedure
    begin
      MemoAnonymous.Lines.Add(
        Format('%S, %S %S', [
          ClientDataSet.FieldByName('LastName').AsString, ClientDataSet.FieldByName('FirstName').AsString,
          CurrToStrF(ClientDataSet.FieldByName('Salary').AsCurrency, ffCurrency, 0, FormatSettings)
        ])
      );
    end
  );
end;

end.
