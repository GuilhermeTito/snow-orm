unit SnowORM.Data.Interfaces;

interface

uses
  SnowORM.Connection.Interfaces, Data.DB;

type
  ISnowTable = interface
    ['{E36853D6-714B-453D-99F7-DCB4D473C19C}']
    function Connection: ISnowConnection; overload;
    procedure Connection(AConnection: ISnowConnection); overload;
    function DataSet: TDataSet;
    function TableName: string; overload;
    procedure TableName(const ATableName: string); overload;
    function Filter: string; overload;
    procedure Filter(const AFilter: string); overload;
    function Filtered: Boolean; overload;
    procedure Filtered(const AFiltered: Boolean); overload;
    procedure Open;
    procedure Close;
    function IsActive: Boolean;
    procedure First;
    procedure Next;
    function RecordCount: Integer;
    function Eof: Boolean;
    procedure Append;
    procedure Edit;
    procedure Delete;
    procedure Post;
    procedure ApplyUpdates;
    function FindField(const AFieldName: string): TField;
    function FieldByName(const AFieldName: string): TField;
  end;

  ISnowTableFactory = interface
    ['{03D28FB2-989C-41C6-BAA5-19D05E4C44FF}']
    function NewTable: ISnowTable;
  end;

implementation

end.
