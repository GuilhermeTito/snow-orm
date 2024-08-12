unit SnowORM.Connection.IBX;

interface

uses
  SnowORM.Connection.Interfaces, Data.DB, IBX.IBDatabase;

type
  TSnowIBXConnection = class (TInterfacedObject, ISnowConnection)
    private
      FDataAccessComponent: TIBDatabase;
    public
      constructor Create(ADataAccessComponent: TCustomConnection);
      class function New(ADataAccessComponent: TCustomConnection): ISnowConnection;
      function GetDataAccessComponent: TCustomConnection;
      procedure SetDataAccessComponent(ADataAccessComponent: TCustomConnection);
      procedure Open;
      procedure Close;
      procedure StartTransaction;
      function InTransaction: Boolean;
      procedure Rollback;
      procedure Commit;
  end;

implementation

{ TSnowIBXConnection }

procedure TSnowIBXConnection.Close;
begin
  FDataAccessComponent.Close;
end;

procedure TSnowIBXConnection.Commit;
begin
  FDataAccessComponent.DefaultTransaction.Commit;
end;

constructor TSnowIBXConnection.Create(ADataAccessComponent: TCustomConnection);
begin
  FDataAccessComponent := ADataAccessComponent as TIBDatabase;
end;

function TSnowIBXConnection.GetDataAccessComponent: TCustomConnection;
begin
  Result := FDataAccessComponent;
end;

function TSnowIBXConnection.InTransaction: Boolean;
begin
  Result := FDataAccessComponent.DefaultTransaction.InTransaction;
end;

class function TSnowIBXConnection.New(ADataAccessComponent: TCustomConnection): ISnowConnection;
begin
  Result := Self.Create(ADataAccessComponent);
end;

procedure TSnowIBXConnection.Open;
begin
  FDataAccessComponent.Open;
end;

procedure TSnowIBXConnection.Rollback;
begin
  FDataAccessComponent.DefaultTransaction.Rollback;
end;

procedure TSnowIBXConnection.SetDataAccessComponent(
  ADataAccessComponent: TCustomConnection);
begin
  FDataAccessComponent := ADataAccessComponent as TIBDatabase;
end;

procedure TSnowIBXConnection.StartTransaction;
begin
  FDataAccessComponent.DefaultTransaction.StartTransaction;
end;

end.
