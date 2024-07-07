unit SnowORM.Connection.Interfaces;

interface

uses
  Data.DB;

type
  ISnowDACAdapter = interface
    ['{E4C5CA59-5DDC-4281-AA3A-7FBFB4F63AFB}']
    function GetConnectionComponent: TCustomConnection;
    procedure SetConnectionComponent(var AConnectionComponent: TCustomConnection);
    function ExecSQL(const ASQL: string): Integer; overload;
    function ExecSQL(const ASQL: string; var AResultSet: TDataSet): Integer; overload;
  end;

  ISnowConnection = interface
    ['{0FA1DDA4-EA7D-4C5A-A911-6CAD0F936ED8}']
    function GetDataAccessComponent: ISnowDACAdapter;
    procedure SetDataAccessComponent(var AConnectionComponent: ISnowDACAdapter);
    function ExecSQL(const ASQL: string): Integer; overload;
    function ExecSQL(const ASQL: string; var AResultSet: TDataSet): Integer; overload;
  end;

implementation

end.
