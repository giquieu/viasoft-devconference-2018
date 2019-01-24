unit UnitMain;

interface

uses
  Contnrs, // TObjectList
  System.Generics.Collections, // TObjectList<T>
  RTTI,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type

  TSQLInsert<T> = class
  private
    FInstance: TObject;
  public
    constructor Create(AInstance: TObject);
    function Generate(): String;
  end;

  TPessoa = class
  private
    FNome: String;
  public
    property Nome: String read FNome write FNome;
  end;

  // Delphi < 2009
  TPessoaList = class(TObjectList)
  private
    procedure SetItem(Index: Integer; const Value: TPessoa);
    function  GetItem(Index: Integer): TPessoa;
  public
    function Add(APessoa: TPessoa): Integer;
    function First: TPessoa;
    function Last: TPessoa;
    // Default = Permite Buscar os Elementos através de VariavelDaLista[]...
    property Items[Index: Integer]: TPessoa read GetItem write SetItem; default;
  end;

  // Com o Delphi 2009 surgiu a System.Generics.Collections
  //TObjectList<TPessoa>;

  TFormMain = class(TForm)
    ButtonLista: TButton;
    ButtonListaGeneric: TButton;
    ButtonGeneric: TButton;
    PanelHeader: TPanel;
    MemoLog: TMemo;
    procedure ButtonListaClick(Sender: TObject);
    procedure ButtonListaGenericClick(Sender: TObject);
    procedure ButtonGenericClick(Sender: TObject);
  private
    { Private declarations }
    FLista2009: TPessoaList;
    FListaGenerica: TObjectList<TPessoa>;
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

{ TPessoaList }

function TPessoaList.Add(APessoa: TPessoa): Integer;
begin
  Result := inherited Add(APessoa);
end;

function TPessoaList.First: TPessoa;
begin
  Result := TPessoa(inherited First);
end;

function TPessoaList.GetItem(Index: Integer): TPessoa;
begin
  //Result := inherited GetItem(Index);

  // Precisa sempre Trabalhar com TypeCast...
  Result := TPessoa(inherited GetItem(Index));
end;

function TPessoaList.Last: TPessoa;
begin
  Result := TPessoa(inherited Last);
end;

procedure TPessoaList.SetItem(Index: Integer; const Value: TPessoa);
begin
  inherited SetItem(Index, Value);
end;

procedure TFormMain.ButtonGenericClick(Sender: TObject);
var
  SQL: TSQLInsert<TPessoa>;
  Pessoa: TPessoa;
  Button: TButton absolute Sender; // Variavel Absoluta do Tipo do Sender, evita ficar fazendo TypeCast...
begin
  SQL := Nil;
  Pessoa := TPessoa.Create;
  try
    Pessoa.Nome := 'DevConference';
    SQL := TSQLInsert<TPessoa>.Create(Pessoa);
    MemoLog.Lines.Add(SQL.Generate());
  finally
    SQL.Free;
    Pessoa.Free;
  end;
end;

procedure TFormMain.ButtonListaClick(Sender: TObject);
var
  Pessoa: TPessoa;
begin
  if not Assigned(FLista2009) then
    FLista2009 := TPessoaList.Create(True);

  Pessoa := TPessoa.Create;
  Pessoa.Nome := 'Delphi < 2009';

  FLista2009.Add(Pessoa);
end;

procedure TFormMain.ButtonListaGenericClick(Sender: TObject);
var
  Pessoa: TPessoa;
begin
  if not Assigned(FListaGenerica) then
    FListaGenerica := TObjectList<TPessoa>.Create(True);

  Pessoa := TPessoa.Create;
  Pessoa.Nome := 'Delphi >= 2009';

  FListaGenerica.Add(Pessoa);
end;

{ TSQLInsert<T> }

constructor TSQLInsert<T>.Create(AInstance: TObject);
begin
  FInstance := AInstance;
end;

function TSQLInsert<T>.Generate(): String;
var
  I: Integer;
  CTX: TRttiContext;
  ClassType: TRttiType;
  SB: TStringBuilder;
begin
  SB := TStringBuilder.Create;
  try
    CTX := TRttiContext.Create;
    ClassType := CTX.GetType(FInstance.ClassType);

    SB.Append('INSERT INTO ' + ClassType.Name + ' (');
    for I := 0 to High(ClassType.GetProperties) do
      begin
      if not (ClassType.GetProperties[I].PropertyType.TypeKind in [tkClass, tkInterface]) then
      begin
        SB.Append(ClassType.GetProperties[I].Name);
        if I < High(ClassType.GetProperties) then SB.Append(', ');
      end;
    end;
    SB.Append(') VALUES (');
    for I := 0 to High(ClassType.GetProperties) do
      begin
      if not (ClassType.GetProperties[I].PropertyType.TypeKind in [tkClass, tkInterface]) then
      begin
        if ClassType.GetProperties[I].PropertyType.TypeKind in [tkString, tkUString] then
          SB.Append(QuotedStr(ClassType.GetProperties[I].GetValue(FInstance).ToString))
        else
          SB.Append(ClassType.GetProperties[I].GetValue(FInstance).ToString);
        if I < High(ClassType.GetProperties) then SB.Append(', ');
      end;
    end;
    SB.Append(')');
    Result := SB.ToString;
  finally
    SB.Free;
  end;
end;

end.
