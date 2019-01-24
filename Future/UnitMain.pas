unit UnitMain;

interface

uses
  System.Threading,
  System.Generics.Collections,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type

  TFormMain = class(TForm)
    MemoLog: TMemo;
    PanelHeader: TPanel;
    ButtonAsync: TButton;
    procedure ButtonAsyncClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TLimiteDeCredito = class
  private
    FLimite: Double;
  public
    property Limite: Double read FLimite write FLimite;
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

procedure TFormMain.ButtonAsyncClick(Sender: TObject);
var
  FutureAsync: IFuture<TLimiteDeCredito>;
  FutureAsyncThread: TThread;
begin
  // Esta Future Retorna uma Lista de Pessoas..
  FutureAsync := TTask.Future<TLimiteDeCredito>(function: TLimiteDeCredito
  begin
    TThread.Queue(TThread.CurrentThread, procedure
      begin
        MemoLog.Lines.Add('Iniciando o Future...');
      end
    );

    Result := TLimiteDeCredito.Create;
    Result.Limite := Random(2018) * Frac(Now);

    Sleep(3000);

    TThread.Queue(TThread.CurrentThread, procedure
      begin
        MemoLog.Lines.Add('Future Finalizou...');
      end
    );
  end);

  MemoLog.Lines.Add('Aguardando o Future...');

  // Buscar o Valor da Future, caso ela não terminou de Processar, é travado aqui até que ela retorne o Result...
  // -> MemoLog.Lines.Add('Valor ' + FutureAsync.Value.Limite.ToString());

  // Se precisa, iniciar uma Thread Anonima para não Travar a Tela ao Buscar o Resultado da Future...
  FutureAsyncThread := TThread.CreateAnonymousThread(procedure
    var
      Limite: TLimiteDeCredito;
    begin
      // Caso já tenha sido chamada FutureAsync.Value a Future não executa de novo, traz o resultado já calculado...
      Limite := FutureAsync.Value;

      // Este NIL está aqui, ao usar a Future dentro dessa Thread o Contador de Referencia é Incrementado,
      // então é passado Nil, Decrementar o RefCount...
      FutureAsync := Nil;

      TThread.Queue(Nil, procedure
        begin
          MemoLog.Lines.Add(Limite.Limite.ToString());
        end
      );
      Limite.Free;
    end
  );

  FutureAsyncThread.FreeOnTerminate := True;

  // Se precisar, executar o Future sem Congelar a Tela...
  FutureAsyncThread.Start;

end;

end.
