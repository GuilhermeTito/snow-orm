unit SnowORM.Mapping.Attributes;

interface

uses SnowORM.Mapping.Properties;

type
  Table = class(TCustomAttribute)
  private
    FName: string;
  public
    constructor Create(const AName: string);
    property Name: string read FName;
  end;

  Column = class(TCustomAttribute)
  private
    FName: string;
    FPrimaryKey: Boolean;
    FUnique: Boolean;
    FRequired: Boolean;
    FNoInsert: Boolean;
    FNoUpdate: Boolean;
  public
    constructor Create(const AName: string); overload;
    constructor Create(const AName: string; const AProperties: TSnowColumnProperties); overload;
    property Name: string read FName;
    property PrimaryKey: Boolean read FPrimaryKey write FPrimaryKey;
    property Unique: Boolean read FUnique default False;
    property Required: Boolean read FRequired default False;
    property NoInsert: Boolean read FNoInsert default False;
    property NoUpdate: Boolean read FNoUpdate default False;
  end;

implementation

{ Table }

constructor Table.Create(const AName: string);
begin
  FName := AName;
end;

{ Column }

constructor Column.Create(const AName: string;
  const AProperties: TSnowColumnProperties);
var
  LProperty: TSnowColumnProperty;
begin
  FName := AName;

  for LProperty in AProperties do
  begin
    case LProperty of
      scpPrimaryKey: FPrimaryKey := True;
      scpUnique: FUnique := True;
      scpRequired: FRequired := True;
      scpNoInsert: FNoInsert := True;
      scpNoUpdate: FNoUpdate := True;
    end;
  end;
end;

constructor Column.Create(const AName: string);
begin
  FName := AName;
end;

end.
