unit SnowORM.Connection.Adapters.FireDAC;

interface

uses
  SnowORM.Connection.Interfaces, Data.DB, FireDAC.Comp.Client;

type
  TSnowFireDACAdapter = class (TInterfacedObject, ISnowConnection)
    private
      FDataAccessComponent: TFDConnection;
    public
      class function New: ISnowConnection;
      function GetDataAccessComponent: TCustomConnection;
      procedure SetDataAccessComponent(var ADataAccessComponent: TCustomConnection);
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

{ TSnowFireDACAdapter }

function TSnowFireDACAdapter.ExecSQL(const ASQL: string): Integer;
begin
  Result := FDataAccessComponent.ExecSQL(ASQL);
end;

procedure TSnowFireDACAdapter.Close;
begin
  FDataAccessComponent.Connected := False;
end;

procedure TSnowFireDACAdapter.Commit;
begin
  FDataAccessComponent.Commit;
end;

function TSnowFireDACAdapter.ExecSQL(const ASQL: string;
  var AResultSet: TDataSet): Integer;
begin
  Result := FDataAccessComponent.ExecSQL(ASQL, AResultSet);
end;

function TSnowFireDACAdapter.GetDataAccessComponent: TCustomConnection;
begin
  Result := FDataAccessComponent;
end;

function TSnowFireDACAdapter.InTransaction: Boolean;
begin
  Result := FDataAccessComponent.InTransaction;
end;

class function TSnowFireDACAdapter.New: ISnowConnection;
begin
  Result := Self.Create;
end;

procedure TSnowFireDACAdapter.Open;
begin
  FDataAccessComponent.Connected := True;
end;

procedure TSnowFireDACAdapter.Rollback;
begin
  FDataAccessComponent.Rollback;
end;

procedure TSnowFireDACAdapter.SetDataAccessComponent(
  var ADataAccessComponent: TCustomConnection);
begin
  FDataAccessComponent := ADataAccessComponent as TFDConnection;
end;

procedure TSnowFireDACAdapter.StartTransaction;
begin
  FDataAccessComponent.StartTransaction;
end;

end.
