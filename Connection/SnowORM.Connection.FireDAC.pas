unit SnowORM.Connection.FireDAC;

interface

uses
  SnowORM.Connection.Interfaces, Data.DB, FireDAC.Comp.Client;

type
  TSnowFireDACConnection = class (TInterfacedObject, ISnowConnection)
    private
      FDataAccessComponent: TFDConnection;
    public
      class function New: ISnowConnection;
      function GetDataAccessComponent: TCustomConnection;
      procedure SetDataAccessComponent(ADataAccessComponent: TCustomConnection);
      procedure Open;
      procedure Close;
      procedure StartTransaction;
      function InTransaction: Boolean;
      procedure Rollback;
      procedure Commit;
      function ExecSQL(const ASQL: string): Integer; overload;
      function ExecSQL(const ASQL: string; var AResultSet: TDataSet): Integer; overload;
  end;

implementation

{ TSnowFireDACConnection }

function TSnowFireDACConnection.ExecSQL(const ASQL: string): Integer;
begin
  Result := FDataAccessComponent.ExecSQL(ASQL);
end;

procedure TSnowFireDACConnection.Close;
begin
  FDataAccessComponent.Connected := False;
end;

procedure TSnowFireDACConnection.Commit;
begin
  FDataAccessComponent.Commit;
end;

function TSnowFireDACConnection.ExecSQL(const ASQL: string;
  var AResultSet: TDataSet): Integer;
begin
  Result := FDataAccessComponent.ExecSQL(ASQL, AResultSet);
end;

function TSnowFireDACConnection.GetDataAccessComponent: TCustomConnection;
begin
  Result := FDataAccessComponent;
end;

function TSnowFireDACConnection.InTransaction: Boolean;
begin
  Result := FDataAccessComponent.InTransaction;
end;

class function TSnowFireDACConnection.New: ISnowConnection;
begin
  Result := Self.Create;
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
