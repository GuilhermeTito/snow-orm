unit SnowORM.Connection.Interfaces;

interface

uses
  Data.DB;

type
  ISnowConnection = interface
    ['{0FA1DDA4-EA7D-4C5A-A911-6CAD0F936ED8}']
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

end.
