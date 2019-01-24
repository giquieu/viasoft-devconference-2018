unit UnitMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type

  TClasseSealed = class sealed
  end;

  //TClasseSealedHeranca = class(TClasseSealed)
  //end;

  TClasseAbstract = class abstract
  public
    procedure Abstrata;
    //procedure Abstrata; virtual; abstract;
  end;

  TFormMain = class(TForm)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

end.
