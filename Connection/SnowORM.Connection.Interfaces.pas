unit SnowORM.Connection.Interfaces;

interface

uses
  Data.DB;

type
  ISnowConnection = interface
    ['{0FA1DDA4-EA7D-4C5A-A911-6CAD0F936ED8}']
    function GetDataAccessComponent: TCustomConnection;
    procedure SetDataAccessComponent(ADataAccessComponent: TCustomConnection);
    procedure Open;
    procedure Close;
    procedure StartTransaction;
    function InTransaction: Boolean;
    procedure Rollback;
    procedure Commit;
  end;

  ISnowConnectionFactory = interface
    ['{E4D71B12-1B44-4FD1-9DBD-2E2BAE204D2F}']
    function NewConnection: ISnowConnection;
  end;

implementation

end.
