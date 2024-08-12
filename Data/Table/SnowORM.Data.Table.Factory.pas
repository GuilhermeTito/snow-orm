unit SnowORM.Data.Table.Factory;

interface

uses
  SnowORM.Connection.Interfaces, SnowORM.Data.Interfaces;

type
  TSnowTableFactory = class(TInterfacedObject, ISnowTableFactory)
  private
    FConnection: ISnowConnection;
  public
    constructor Create(AConnection: ISnowConnection);
    class function New(AConnection: ISnowConnection): ISnowTableFactory;
    function NewTable: ISnowTable;
  end;

implementation

uses
  SnowORM.Connection.FireDAC, SnowORM.Data.Table.FireDAC,
  SnowORM.Connection.IBX, SnowORM.Data.Table.IBX;

{ TSnowTableFactory }

constructor TSnowTableFactory.Create(AConnection: ISnowConnection);
begin
  FConnection := AConnection;
end;

class function TSnowTableFactory.New(
  AConnection: ISnowConnection): ISnowTableFactory;
begin
  Result := Self.Create(AConnection);
end;

function TSnowTableFactory.NewTable: ISnowTable;
begin
  if FConnection is TSnowFireDACConnection then
  begin
    Result := TSnowFireDACTable.New(FConnection);
    Exit;
  end;

  if FConnection is TSnowIBXConnection then
  begin
    Result := TSnowIBXTable.New(FConnection);
    Exit;
  end;
end;

end.
