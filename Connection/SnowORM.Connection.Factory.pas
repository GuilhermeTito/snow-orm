unit SnowORM.Connection.Factory;

interface

uses
  SnowORM.Connection.Interfaces, Data.DB;

type
  TSnowConnectionFactory = class(TInterfacedObject, ISnowConnectionFactory)
  private
    FDataAccessComponent: TCustomConnection;
  public
    constructor Create(ADataAccessComponent: TCustomConnection);
    class function New(ADataAccessComponent: TCustomConnection): ISnowConnectionFactory;
    function NewConnection: ISnowConnection;
  end;

implementation

uses
  FireDAC.Comp.Client, IBX.IBDatabase, SnowORM.Connection.FireDAC,
  SnowORM.Connection.IBX;

{ TSnowConnectionFactory }

constructor TSnowConnectionFactory.Create(ADataAccessComponent: TCustomConnection);
begin
  FDataAccessComponent := ADataAccessComponent;
end;

class function TSnowConnectionFactory.New(
  ADataAccessComponent: TCustomConnection): ISnowConnectionFactory;
begin
  Result := Self.Create(ADataAccessComponent)
end;

function TSnowConnectionFactory.NewConnection: ISnowConnection;
begin
  if FDataAccessComponent is TFDConnection then
  begin
    Result := TSnowFireDACConnection.New(FDataAccessComponent);
    Exit;
  end;

  if FDataAccessComponent is TIBDatabase then
  begin
    Result := TSnowIBXConnection.New(FDataAccessComponent);
    Exit;
  end;
end;

end.
