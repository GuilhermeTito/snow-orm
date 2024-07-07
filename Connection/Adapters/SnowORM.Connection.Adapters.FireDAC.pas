unit SnowORM.Connection.Adapters.FireDAC;

interface

uses
  SnowORM.Connection.Interfaces, Data.DB, FireDAC.Comp.Client;

type
  TSnowFireDACAdapter = class (TInterfacedObject, ISnowDACAdapter)
    private
      FDAC: TFDConnection;
    public
      class function New: ISnowDACAdapter;
      function GetComponent: TCustomConnection;
      procedure SetComponent(var ADAC: TCustomConnection);
      function ExecSQL(const ASQL: string): Integer; overload;
      function ExecSQL(const ASQL: string; var AResultSet: TDataSet): Integer; overload;
  end;

implementation

{ TSnowFireDACAdapter }

function TSnowFireDACAdapter.ExecSQL(const ASQL: string): Integer;
begin
  Result := FDAC.ExecSQL(ASQL);
end;

function TSnowFireDACAdapter.ExecSQL(const ASQL: string;
  var AResultSet: TDataSet): Integer;
begin
  Result := FDAC.ExecSQL(ASQL, AResultSet);
end;

function TSnowFireDACAdapter.GetComponent: TCustomConnection;
begin
  Result := FDAC;
end;

class function TSnowFireDACAdapter.New: ISnowDACAdapter;
begin
  Result := Self.Create;
end;

procedure TSnowFireDACAdapter.SetComponent(
  var ADAC: TCustomConnection);
begin
  FDAC := ADAC as TFDConnection;
end;

end.
