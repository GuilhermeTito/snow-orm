unit SnowORM.Connection.FireDAC;

interface

uses
  SnowORM.Connection.Interfaces, Data.DB, FireDAC.Comp.Client;

type
  TSnowFireDACConnection = class (TInterfacedObject, ISnowConnection)
    private
      FDataAccessComponent: TFDConnection;
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

{ TSnowFireDACConnection }

procedure TSnowFireDACConnection.Close;
begin
  FDataAccessComponent.Connected := False;
end;

procedure TSnowFireDACConnection.Commit;
begin
  FDataAccessComponent.Commit;
end;

constructor TSnowFireDACConnection.Create(ADataAccessComponent: TCustomConnection);
begin
  FDataAccessComponent := ADataAccessComponent as TFDConnection;
end;

function TSnowFireDACConnection.GetDataAccessComponent: TCustomConnection;
begin
  Result := FDataAccessComponent;
end;

function TSnowFireDACConnection.InTransaction: Boolean;
begin
  Result := FDataAccessComponent.InTransaction;
end;

class function TSnowFireDACConnection.New(ADataAccessComponent: TCustomConnection): ISnowConnection;
begin
  Result := Self.Create(ADataAccessComponent);
end;

procedure TSnowFireDACConnection.Open;
begin
  FDataAccessComponent.Connected := True;
end;

procedure TSnowFireDACConnection.Rollback;
begin
  FDataAccessComponent.Rollback;
end;

procedure TSnowFireDACConnection.SetDataAccessComponent(
  ADataAccessComponent: TCustomConnection);
begin
  FDataAccessComponent := ADataAccessComponent as TFDConnection;
end;

procedure TSnowFireDACConnection.StartTransaction;
begin
  FDataAccessComponent.StartTransaction;
end;

end.
