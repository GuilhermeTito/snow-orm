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
    procedure Insert<T: class>(Entity: T);
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

    FTable.Filtered(True);
    FTable.Filter(AFilter);
    FTable.Open;

    if FTable.RecordCount > 0 then
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
    end;
  finally
    LContext.Free;
    FTable.Close;
    FTable.TableName('');
    FTable.Filtered(False);
    FTable.Filter('');
  end;
end;

procedure TSnowDAO.Insert<T>(Entity: T);
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

    FTable.Open;
    FTable.Append;

    for LProperty in LType.GetProperties do
    begin
      for LAttribute in LProperty.GetAttributes do
      begin
        if LAttribute is Column then
        begin
          if Assigned(FTable.FindField(Column(LAttribute).Name)) then
            FTable.FieldByName(Column(LAttribute).Name).Value := LProperty.GetValue(TObject(Entity)).AsVariant;

          Break;
        end;
      end;
    end;

    FTable.Post;
  finally
    LContext.Free;
    FTable.Close;
    FTable.TableName('');
  end;
end;

end.
