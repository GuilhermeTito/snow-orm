unit SnowORM.Types.Fields.Generic;

interface

uses
  SnowORM.Types.Interfaces;

type
  TSnowField<T> = class(TInterfacedObject, ISnowField)
  private
    FValue: T;
    FIsNull: Boolean;
    procedure SetValue(const AValue: T);
  public
    constructor Create;
    procedure Clear;
    function AsString: string; virtual; abstract;
    property Value: T read FValue write SetValue;
    property IsNull: Boolean read FIsNull;
  end;

implementation            

uses
  System.SysUtils, System.TypInfo, System.Rtti;

{ TSnowField<T> }

constructor TSnowField<T>.Create;
begin
  if not (GetTypeKind(T) in [tkChar, tkWChar, tkString, tkLString, tkWString, tkUString, tkInteger, tkInt64, tkFloat]) then
    raise Exception.Create('Type unsupported by TSnowField');

  Clear;
end;

procedure TSnowField<T>.SetValue(const AValue: T);
begin
  FValue := AValue;
  FIsNull := False;
end;

procedure TSnowField<T>.Clear;
var
  LContext: TRttiContext;
  LType: TRttiType;
  LProperty: TRttiProperty;
  LValue: TValue;
begin
  LContext := TRttiContext.Create;

  try
    LType := LContext.GetType(Self.ClassType);

    for LProperty in LType.GetProperties do
    begin
      if LProperty.Name <> 'Value' then
        Continue;

      case LProperty.PropertyType.TypeKind of
        tkChar, tkWChar, tkString, tkLString, tkWString, tkUString:
          LValue := '';

        tkInteger, tkInt64, tkFloat:
          LValue := 0;
      else
        Break;
      end;

      LProperty.SetValue(Pointer(Self), LValue);
      FIsNull := True;

      Break;
    end;
  finally
    LContext.Free;
  end;
end;

end.
