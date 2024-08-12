unit SnowORM.SQL.Operators;

interface

type
  TSnowLogicalOperator = (loAnd, loOr, loNot);
  TSnowLogicalOperators = set of TSnowLogicalOperator;

  TSnowComparisonOperator = (coEQ, coNE, coGT, coGTE, coLT, coLTE);
  TSnowComparisonOperators = set of TSnowComparisonOperator;

function LogicalOperatorToStr(const LogicalOperator: TSnowLogicalOperator): string;
function LogicalOperationBuilder(const LogicalOperator: TSnowLogicalOperator; const Propositions: TArray<string>): string;
function OpAnd(const Propositions: TArray<string>): string;
function OpOr(const Propositions: TArray<string>): string;
function OpNot(const Proposition: string): string;

function ComparisonOperatorToStr(const ComparisonOperator: TSnowComparisonOperator): string;
function ComparisonOperationBuilder(const FieldName: string; const ComparisonOperator: TSnowComparisonOperator; const Value: Variant): string;
function EQ(const FieldName: string; const Value: Variant): string;
function NE(const FieldName: string; const Value: Variant): string;
function GT(const FieldName: string; const Value: Variant): string;
function GTE(const FieldName: string; const Value: Variant): string;
function LT(const FieldName: string; const Value: Variant): string;
function LTE(const FieldName: string; const Value: Variant): string;

implementation

uses
  System.Variants;

function LogicalOperatorToStr(const LogicalOperator: TSnowLogicalOperator): string;
begin
  Result := '';

  case LogicalOperator of
    loAnd: Result := 'AND';
    loOr: Result := 'OR';
    loNot: Result := 'NOT';
  end;
end;

function LogicalOperationBuilder(const LogicalOperator: TSnowLogicalOperator; const Propositions: TArray<string>): string;
var
  NumberOfPropositions: Integer;
  I: Integer;
begin
  Result := '';

  NumberOfPropositions := Length(Propositions);

  if NumberOfPropositions < 1 then
    Exit;

  if LogicalOperator = loNot then
  begin
    Result := LogicalOperatorToStr(LogicalOperator) + Propositions[0];
    Exit;
  end;

  Result := '(' + Propositions[0] + ')';

  for I := 1 to NumberOfPropositions - 1 do
    Result := Result + ' ' + LogicalOperatorToStr(LogicalOperator) + ' (' + Propositions[1] + ')';
end;

function OpAnd(const Propositions: TArray<string>): string;
begin
  Result := LogicalOperationBuilder(loAnd, Propositions);
end;

function OpOr(const Propositions: TArray<string>): string;
begin
  Result := LogicalOperationBuilder(loOr, Propositions);
end;

function OpNot(const Proposition: string): string;
begin
  Result := LogicalOperationBuilder(loNot, [Proposition]);
end;

function ComparisonOperatorToStr(const ComparisonOperator: TSnowComparisonOperator): string;
begin
  Result := '';

  case ComparisonOperator of
    coEQ: Result := '=';
    coNE: Result := '<>';
    coGT: Result := '>';
    coGTE: Result := '>=';
    coLT: Result := '<';
    coLTE: Result := '<=';
  end;
end;

function ComparisonOperationBuilder(const FieldName: string; const ComparisonOperator: TSnowComparisonOperator; const Value: Variant): string;
begin
  Result := FieldName + ' ' + ComparisonOperatorToStr(ComparisonOperator) + ' ' + VarToStr(Value);
end;

function EQ(const FieldName: string; const Value: Variant): string;
begin
  Result := ComparisonOperationBuilder(FieldName, coEQ, Value);
end;

function NE(const FieldName: string; const Value: Variant): string;
begin
  Result := ComparisonOperationBuilder(FieldName, coNE, Value);
end;

function GT(const FieldName: string; const Value: Variant): string;
begin
  Result := ComparisonOperationBuilder(FieldName, coGT, Value);
end;

function GTE(const FieldName: string; const Value: Variant): string;
begin
  Result := ComparisonOperationBuilder(FieldName, coGTE, Value);
end;

function LT(const FieldName: string; const Value: Variant): string;
begin
  Result := ComparisonOperationBuilder(FieldName, coLT, Value);
end;

function LTE(const FieldName: string; const Value: Variant): string;
begin
  Result := ComparisonOperationBuilder(FieldName, coLTE, Value);
end;

end.
