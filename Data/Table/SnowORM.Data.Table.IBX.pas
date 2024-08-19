unit SnowORM.Data.Table.IBX;

interface

uses
  SnowORM.Data.Interfaces, SnowORM.Connection.Interfaces, Data.DB,
  IBX.IBTable;

type
  TSnowIBXTable = class(TInterfacedObject, ISnowTable)
  private
    FConnection: ISnowConnection;
    FTable: TIBTable;
  public
    constructor Create(AConnection: ISnowConnection);
    destructor Destroy; override;
    class function New(AConnection: ISnowConnection): ISnowTable;
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

implementation

uses
  IBX.IBDatabase;

{ ISnowFireDACTable }

procedure TSnowIBXTable.Append;
begin
  FTable.Append;
end;

procedure TSnowIBXTable.ApplyUpdates;
begin
  FTable.ApplyUpdates;
end;

procedure TSnowIBXTable.Close;
begin
  FTable.Close;
end;

procedure TSnowIBXTable.Connection(AConnection: ISnowConnection);
begin
  FConnection := AConnection;
  FTable.Database := FConnection.GetDataAccessComponent as TIBDatabase;
end;

function TSnowIBXTable.Connection: ISnowConnection;
begin
  Result := FConnection;
end;

constructor TSnowIBXTable.Create(AConnection: ISnowConnection);
begin
  FConnection := AConnection;
  FTable := TIBTable.Create(nil);
  FTable.Database := FConnection.GetDataAccessComponent as TIBDatabase;
end;

function TSnowIBXTable.DataSet: TDataSet;
begin
  Result := FTable;
end;

procedure TSnowIBXTable.Delete;
begin
  FTable.Delete;
end;

destructor TSnowIBXTable.Destroy;
begin
  FTable.Free;
  inherited;
end;

procedure TSnowIBXTable.Edit;
begin
  FTable.Edit;
end;

function TSnowIBXTable.Eof: Boolean;
begin
  Result := FTable.Eof;
end;

function TSnowIBXTable.FieldByName(const AFieldName: string): TField;
begin
  Result := FTable.FieldByName(AFieldName);
end;

procedure TSnowIBXTable.Filter(const AFilter: string);
begin
  FTable.Filter := AFilter;
end;

function TSnowIBXTable.Filter: string;
begin
  Result := FTable.Filter;
end;

function TSnowIBXTable.Filtered: Boolean;
begin
  Result := FTable.Filtered;
end;

procedure TSnowIBXTable.Filtered(const AFiltered: Boolean);
begin
  FTable.Filtered := AFiltered;
end;

function TSnowIBXTable.FindField(const AFieldName: string): TField;
begin
  Result := FTable.FindField(AFieldName);
end;

procedure TSnowIBXTable.First;
begin
  FTable.First;
end;

function TSnowIBXTable.IsActive: Boolean;
begin
  Result := FTable.Active;
end;

class function TSnowIBXTable.New(AConnection: ISnowConnection): ISnowTable;
begin
  Result := Self.Create(AConnection);
end;

procedure TSnowIBXTable.Next;
begin
  FTable.Next;
end;

procedure TSnowIBXTable.Open;
begin
  FTable.Open;
end;

procedure TSnowIBXTable.Post;
begin
  FTable.Post;
end;

function TSnowIBXTable.RecordCount: Integer;
begin
  Result := FTable.RecordCount;
end;

procedure TSnowIBXTable.TableName(const ATableName: string);
begin
  FTable.TableName := ATableName;
end;

function TSnowIBXTable.TableName: string;
begin
  Result := FTable.TableName;
end;

end.
