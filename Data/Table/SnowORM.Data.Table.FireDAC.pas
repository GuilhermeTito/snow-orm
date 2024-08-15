unit SnowORM.Data.Table.FireDAC;

interface

uses
  SnowORM.Data.Interfaces, SnowORM.Connection.Interfaces, Data.DB,
  FireDAC.Comp.Client;

type
  TSnowFireDACTable = class(TInterfacedObject, ISnowTable)
  private
    FConnection: ISnowConnection;
    FTable: TFDTable;
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
    procedure Post;
    procedure ApplyUpdates;
    function FindField(const AFieldName: string): TField;
    function FieldByName(const AFieldName: string): TField;
  end;

implementation

{ ISnowFireDACTable }

procedure TSnowFireDACTable.Append;
begin
  FTable.Append;
end;

procedure TSnowFireDACTable.ApplyUpdates;
begin
  FTable.ApplyUpdates(0);
end;

procedure TSnowFireDACTable.Close;
begin
  FTable.Close;
end;

procedure TSnowFireDACTable.Connection(AConnection: ISnowConnection);
begin
  FConnection := AConnection;
  FTable.Connection := FConnection.GetDataAccessComponent as TFDConnection;
end;

function TSnowFireDACTable.Connection: ISnowConnection;
begin
  Result := FConnection;
end;

constructor TSnowFireDACTable.Create(AConnection: ISnowConnection);
begin
  FConnection := AConnection;
  FTable := TFDTable.Create(nil);
  FTable.Connection := FConnection.GetDataAccessComponent as TFDConnection;
end;

function TSnowFireDACTable.DataSet: TDataSet;
begin
  Result := FTable;
end;

destructor TSnowFireDACTable.Destroy;
begin
  FTable.Free;
  inherited;
end;

procedure TSnowFireDACTable.Edit;
begin
  FTable.Edit;
end;

function TSnowFireDACTable.Eof: Boolean;
begin
  Result := FTable.Eof;
end;

function TSnowFireDACTable.FieldByName(const AFieldName: string): TField;
begin
  Result := FTable.FieldByName(AFieldName);
end;

procedure TSnowFireDACTable.Filter(const AFilter: string);
begin
  FTable.Filter := AFilter;
end;

function TSnowFireDACTable.Filter: string;
begin
  Result := FTable.Filter;
end;

function TSnowFireDACTable.Filtered: Boolean;
begin
  Result := FTable.Filtered;
end;

procedure TSnowFireDACTable.Filtered(const AFiltered: Boolean);
begin
  FTable.Filtered := AFiltered;
end;

function TSnowFireDACTable.FindField(const AFieldName: string): TField;
begin
  Result := FTable.FindField(AFieldName);
end;

procedure TSnowFireDACTable.First;
begin
  FTable.First;
end;

function TSnowFireDACTable.IsActive: Boolean;
begin
  Result := FTable.Active;
end;

class function TSnowFireDACTable.New(AConnection: ISnowConnection): ISnowTable;
begin
  Result := Self.Create(AConnection);
end;

procedure TSnowFireDACTable.Next;
begin
  FTable.Next;
end;

procedure TSnowFireDACTable.Open;
begin
  FTable.Open;
end;

procedure TSnowFireDACTable.Post;
begin
  FTable.Post;
end;

function TSnowFireDACTable.RecordCount: Integer;
begin
  Result := FTable.RecordCount;
end;

procedure TSnowFireDACTable.TableName(const ATableName: string);
begin
  FTable.TableName := ATableName;
end;

function TSnowFireDACTable.TableName: string;
begin
  Result := FTable.TableName;
end;

end.
