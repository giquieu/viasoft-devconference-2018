unit uRuntimeTypeInformation;

interface

uses
  System.Classes, System.Rtti, System.Contnrs;

type
  TRuntimeTypeInformation = class
  private
    FList: TObjectList;
  public
    constructor Create(List: TObjectList);
    procedure GetObjectRTTI(LinesReturn: TStrings);
  end;

implementation

{ TRuntimeTypeInformation }

constructor TRuntimeTypeInformation.Create(List: TObjectList);
begin
  FList := List;
end;

procedure TRuntimeTypeInformation.GetObjectRTTI(LinesReturn: TStrings);
var
  typRtti: TRttiType;
  ctxRtti: TRttiContext;
  proRtti: TRttiProperty;
  MetRtti: TRttiMethod;
  oAtt: TCustomAttribute;
  Objeto: TObject;
  FTab: string;
  i: Integer;
begin
  if not Assigned(FList) then
    Exit;
  for i := 0 to FList.Count-1 do
    begin
    Objeto := FList[i];
    ctxRtti := TRttiContext.Create;
    try
      typRtti := ctxRtti.GetType(Objeto.ClassType);
      LinesReturn.Add(Objeto.ClassName);
      FTab := '  ';
      for proRTTI in typRtti.GetProperties do
        begin
        LinesReturn.Add(FTab + proRtti.Name + ' = ' + proRTTI.GetValue(Objeto).ToString);
        FTab := '    ';
        for oAtt in proRTTI.GetAttributes do
        begin
          LinesReturn.Add(FTab + 'CustomAttribute: ' + oAtt.ToString);
        end;
        FTab := '  ';
      end;
      LinesReturn.Add('');
      for MetRtti in typRtti.GetMethods do
        if MetRtti.Parent.Name = Objeto.ClassName then
          LinesReturn.Add(FTab + 'Method: ' + typRtti.Name + '.' + MetRtti.Name);
      FTab := '';
      LinesReturn.Add('----------');
    finally
      ctxRtti.Free;
    end;
  end;
end;

end.
