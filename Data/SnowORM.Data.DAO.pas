unit SnowORM.Data.DAO;

interface

uses
  SnowORM.Data.Interfaces, SnowORM.Connection.Interfaces, Data.DB, System.Rtti;

type
  TSnowDAO = class
  private
    FTable: ISnowTable;
  public
    constructor Create(AConnection: ISnowConnection);
    procedure Find<T: class>(Entity: T; const AFilter: string = '');
  end;

implementation

uses
  SnowORM.Data.Table.Factory, SnowORM.Mapping.Attributes, SnowORM.Utils;

{ TSnowDAO }

constructor TSnowDAO.Create(AConnection: ISnowConnection);
begin
  FTable := TSnowTableFactory.New(AConnection).NewTable;
end;

procedure TSnowDAO.Find<T>(Entity: T; const AFilter: string = '');
var
  LContext: TRttiContext;
  LType: TRttiType;
  LAttribute: TCustomAttribute;
  LProperty: TRttiProperty;
begin
  LContext := TRttiContext.Create;
  try
    LType := LContext.GetType(T);

    for LAttribute in LType.GetAttributes do
    begin
      if LAttribute is Table then
      begin
        FTable.TableName(Table(LAttribute).Name);
        Break;
      end;
    end;

    FTable.Filter(AFilter);

    FTable.Open;

    if FTable.RecordCount > 0 then
    begin
      FTable.First;

      while not FTable.Eof do
      begin
        for LProperty in LType.GetProperties do
        begin
          for LAttribute in LProperty.GetAttributes do
          begin
            if LAttribute is Column then
            begin
              if Assigned(FTable.FindField(Column(LAttribute).Name)) then
                LProperty.SetValue(TObject(Entity), FieldToTValue(FTable.FieldByName(Column(LAttribute).Name)));

              Break;
            end;
          end;
        end;

        FTable.Next;
      end;
    end;
  finally
    LContext.Free;
    FTable.Close;
  end;
end;

end.
