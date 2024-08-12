unit SnowORM.Utils;

interface

uses
  Data.DB, System.Rtti;

function FieldToTValue(AField: TField): TValue;

implementation

uses
  System.Variants, Data.FmtBcd;

function FieldToTValue(AField: TField): TValue;
var
  LValue: Variant;
  LVarType: TVarType;
begin
  try
    LValue := AField.Value;

    LVarType := VarType(LValue);

    if LVarType = 271 then // Firebird timestamp
    begin
      LValue   := LValue.AsDateTime;
      LVarType := VarType(LVarType);
    end;

    if LVarType = VarFMTBcd then
      Result := TValue.FromVariant(BcdToDouble(VarToBcd(LValue)))
    else
      Result := TValue.FromVariant(LValue);
  except
    raise;
  end;
end;

end.
