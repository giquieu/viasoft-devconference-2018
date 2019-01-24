unit UnitMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Threading, Vcl.StdCtrls, SyncObjs, Vcl.ExtCtrls,
  ComObj, ActiveX,Vcl.Menus, cxButtons, System.Generics.Collections, Vcl.ComCtrls;

type

  TGeradorDeArquivo = class;

  TGeradorDeArquivoStatusPanel = class(TComponent)
  private
    [Weak]
    FGeradorDeArquivo: TGeradorDeArquivo;
    FPanel: TPanel;
    FButtonCancelar: TcxButton;
    FPanelInner: TPanel;
    FLabelTitle: TLabel;
    FProgressBar: TProgressBar;
    FAlign: TAlign;
    FTitle: String;
    FProgressEnabled: Boolean;
    procedure SetAlign(const Value: TAlign);
    procedure SetTitle(const Value: String);
    procedure SetProgressEnabled(const Value: Boolean);
    procedure DoButtonCancelar(Sender: TObject);
  public
    constructor Create(AOwner: TComponent; const AGeradorDeArquivo: TGeradorDeArquivo); reintroduce;
    property Align: TAlign read FAlign write SetAlign;
    property Title: String read FTitle write SetTitle;
    property ProgressEnabled: Boolean read FProgressEnabled write SetProgressEnabled;
  end;

  TGeradorDeArquivoAoTerminar = Reference to Procedure(AGerador: TGeradorDeArquivo);

  TGeradorDeArquivo = class(TObject)
  private
    [Weak]
    FTask: ITask;
    [Weak]
    FOwner: TComponent;
    FPanelStatus: TGeradorDeArquivoStatusPanel;
    FExecutarProcAoTerminar: TGeradorDeArquivoAoTerminar;
    FExecutarProcAoCancelar: TGeradorDeArquivoAoTerminar;
    FTaskID: String;
    function GetTaskID: String;
  public
    constructor Create; reintroduce;
    destructor  Destroy; override;
    class function Iniciar: TGeradorDeArquivo;
    procedure Gerar;
    procedure Cancelar;
    function MostrarStatusPanel(AOwner: TComponent): TGeradorDeArquivo;
    function ExecutarAoTerminar(const AProc: TGeradorDeArquivoAoTerminar): TGeradorDeArquivo;
    function ExecutarAoCancelar(const AProc: TGeradorDeArquivoAoTerminar): TGeradorDeArquivo;
    property TaskID: String read GetTaskID;
  end;

  TFormMain = class(TForm)
    ButtonSimpleTask: TButton;
    ButtonTask: TButton;
    PanelContainer: TPanel;
    ScrollBox: TScrollBox;
    MemoLog: TMemo;
    LabelPAth: TLabel;
    procedure ButtonSimpleTaskClick(Sender: TObject);
    procedure ButtonTaskClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    GeradorDeArquivoList: TDictionary<String, TGeradorDeArquivo>;
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

procedure TFormMain.ButtonSimpleTaskClick(Sender: TObject);
var
  Task: ITask;
begin
  Task := TTask.Create (procedure()
    begin
    Sleep(3000);
    ShowMessage('Hello');
  end);
  Task.Start;
end;

procedure TFormMain.ButtonTaskClick(Sender: TObject);
var
  Gerador: TGeradorDeArquivo;
begin
  Gerador := TGeradorDeArquivo.Iniciar
    .MostrarStatusPanel(ScrollBox)
    .ExecutarAoCancelar(procedure(AGerador: TGeradorDeArquivo)
      begin
        TThread.Queue(TThread.CurrentThread, procedure()
          begin
          if Assigned(MemoLog) then
            MemoLog.Lines.Add('Cancelou a Task: ' + AGerador.TaskID);
          GeradorDeArquivoList.Remove(AGerador.TaskID);
          AGerador.Free;
        end)
      end
    )
    .ExecutarAoTerminar(procedure(AGerador: TGeradorDeArquivo)
      begin
        TThread.Queue(TThread.CurrentThread, procedure()
          begin
          if Assigned(MemoLog) then
            MemoLog.Lines.Add('Terminou a Task: ' + AGerador.TaskID);
          GeradorDeArquivoList.Remove(AGerador.TaskID);
          AGerador.Free;
        end)
      end
    );
  GeradorDeArquivoList.Add(Gerador.TaskID, Gerador);
  Gerador.Gerar;
end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  GeradorDeArquivoList := TDictionary<String, TGeradorDeArquivo>.Create();
end;

procedure TFormMain.FormDestroy(Sender: TObject);
var
  Gerador: TPair<String, TGeradorDeArquivo>;
  I: Integer;
begin
  for Gerador in GeradorDeArquivoList do
    begin
    Gerador.Value.Cancelar;
  end;
  for Gerador in GeradorDeArquivoList do
    begin
    Gerador.Value.Free;
  end;
  GeradorDeArquivoList.Clear;
  GeradorDeArquivoList.Free;
end;

{ TGeradorDeArquivo }

function TGeradorDeArquivo.ExecutarAoCancelar(const AProc: TGeradorDeArquivoAoTerminar): TGeradorDeArquivo;
begin
  FExecutarProcAoCancelar := AProc;
  Result := Self;
end;

function TGeradorDeArquivo.ExecutarAoTerminar(const AProc: TGeradorDeArquivoAoTerminar): TGeradorDeArquivo;
begin
  FExecutarProcAoTerminar := AProc;
  Result := Self;
end;

procedure TGeradorDeArquivo.Cancelar;
begin
  FTask.Cancel;
end;

function TGeradorDeArquivo.MostrarStatusPanel(AOwner: TComponent): TGeradorDeArquivo;
begin
  FOwner := AOwner;
  Result := Self;
end;

constructor TGeradorDeArquivo.Create;
begin
  FTaskID := EmptyStr;
end;

destructor TGeradorDeArquivo.Destroy;
begin
  if Assigned(FPanelStatus) then FreeAndNil(FPanelStatus);
  inherited;
end;

procedure TGeradorDeArquivo.Gerar;
begin

  TThread.Queue(TThread.CurrentThread, procedure()
    begin
    FPanelStatus := TGeradorDeArquivoStatusPanel.Create(FOwner, Self);
    FPanelStatus.Align := alTop;
    FPanelStatus.ProgressEnabled := True;
    FPanelStatus.Title := TaskID;
  end);

  FTask := TTask.Create(procedure()
    var
      Lista: TStringList;
      TaskIDAux: String;
      Index: Integer;
      begin
      if (TTask.CurrentTask.Status <> TTaskStatus.Canceled) then
        begin
        TaskIDAux := TaskID;
        Lista := NIL;

        try
          Lista := TStringList.Create;
          Lista.Add('>> Task ' + TaskID + ' <<');
          Index := 0;
          while (TTask.CurrentTask.Status <> TTaskStatus.Canceled) do
            begin
            Lista.Add(Index.ToString() + ' -> CurrentThread.ThreadID: ' + TThread.CurrentThread.ThreadID.ToString());
            Inc(Index);
            Sleep(1000);
            if (Index = 5) then
              begin
              Break;
            end;
          end;
          if (not (DirectoryExists('C:\Temp\Resultado\'))) then
            begin
            ForceDirectories('C:\Temp\Resultado\');
          end;
          Lista.SaveToFile('C:\Temp\Resultado\' +  TaskIDAux + '.txt');
        finally
          Lista.Free;
        end;

        if (TTask.CurrentTask.Status = TTaskStatus.Canceled) then
          begin
          TThread.Queue(TThread.CurrentThread, procedure()
            begin
            if (not (Application.Terminated)) then
              begin
              if Assigned(FExecutarProcAoCancelar) then FExecutarProcAoCancelar(Self);
              if Assigned(FPanelStatus) then FPanelStatus.Free;
            end;
          end);
        end
        else
          begin
          TThread.Queue(TThread.CurrentThread, procedure()
            begin
            if (not (Application.Terminated)) then
              begin
              if Assigned(FExecutarProcAoTerminar) then FExecutarProcAoTerminar(Self);
              if Assigned(FPanelStatus) then FPanelStatus.Free;
            end;
          end);
        end;

      end
    end
  );
  FTask.Start;
end;

function TGeradorDeArquivo.GetTaskID: String;
var
  ID: TGUID;
begin
  if (FTaskID = EmptyStr) then
    begin
    CoCreateGuid(ID);
    FTaskID := GUIDToString(ID);
  end;
  Result := FTaskID;
end;

class function TGeradorDeArquivo.Iniciar: TGeradorDeArquivo;
begin
  Result := TGeradorDeArquivo.Create;
end;

{ TGeradorDeArquivoStatusPanel }

constructor TGeradorDeArquivoStatusPanel.Create(AOwner: TComponent; const AGeradorDeArquivo: TGeradorDeArquivo);
begin
  inherited Create(AOwner);
  FGeradorDeArquivo := AGeradorDeArquivo;

  FPanel := TPanel.Create(Self);
  FButtonCancelar := TcxButton.Create(Self);
  FPanelInner := TPanel.Create(Self);
  FLabelTitle := TLabel.Create(Self);
  FProgressBar := TProgressBar.Create(Self);

  FPanel.Name := 'Panel';
  FPanel.Parent := TWinControl(Self.Owner);
  FPanel.BevelOuter := bvNone;
  FPanel.TabStop := False;
  FPanel.Caption := EmptyStr;

  FPanel.Width := 417;
  FPanel.Height := 45;

  FButtonCancelar.Name := 'ButtonCancelar';
  FButtonCancelar.Parent := FPanel;
  FButtonCancelar.AlignWithMargins := True;
  FButtonCancelar.Width := 60;
  FButtonCancelar.Align := alRight;
  FButtonCancelar.Caption := 'Cancelar';
  FButtonCancelar.TabStop := False;
  FButtonCancelar.OnClick := DoButtonCancelar;

  FPanelInner.Name := 'PanelInner';
  FPanelInner.Parent := FPanel;
  FPanelInner.Align := alClient;
  FPanelInner.BevelOuter := bvNone;
  FPanelInner.TabStop := False;
  FPanelInner.Caption := EmptyStr;

  FProgressBar.Name := 'ProgressBar';
  FProgressBar.Parent := FPanelInner;
  FProgressBar.AlignWithMargins := True;
  FProgressBar.Align := alBottom;
  FProgressBar.Height := 20;
  FProgressBar.TabStop := False;
  FProgressBar.Style := pbstMarquee;
  FProgressBar.MarqueeInterval := 10;


  FLabelTitle.Name := 'LabelTitle';
  FLabelTitle.Parent := FPanelInner;
  FLabelTitle.AlignWithMargins := True;
  FLabelTitle.Align := alClient;
  FLabelTitle.Caption := 'Descri'#231#227'o';
end;

procedure TGeradorDeArquivoStatusPanel.DoButtonCancelar(Sender: TObject);
begin
  FGeradorDeArquivo.FTask.Cancel;
end;

procedure TGeradorDeArquivoStatusPanel.SetAlign(const Value: TAlign);
begin
  FAlign := Value;
  FPanel.Align := FAlign;
end;

procedure TGeradorDeArquivoStatusPanel.SetProgressEnabled(const Value: Boolean);
begin
  FProgressEnabled := Value;
  FProgressBar.Enabled := FProgressEnabled;
end;

procedure TGeradorDeArquivoStatusPanel.SetTitle(const Value: String);
begin
  FTitle := Value;
  FLabelTitle.Caption := FTitle;
end;

end.
