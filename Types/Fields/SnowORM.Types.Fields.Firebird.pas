unit SnowORM.Types.Fields.Firebird;

interface

uses
  SnowORM.Types.Fields.Generic;

type
  TFBInteger = class(TSnowField<Integer>)
  public
    function AsString: string; override;
  end;

  TFBFloat = class(TSnowField<Single>)
  public
    function AsString: string; override;
  end;

  TFBDoublePrecision = class(TSnowField<Double>)
  public
    function AsString: string; override;
  end;

  TFBDate = class(TSnowField<TDate>)
  public
    function AsString: string; override;
  end;

implementation

uses
  System.SysUtils, System.DateUtils;

{ TFBInteger }

function TFBInteger.AsString: string;
begin
  Result := IntToStr(Value);
end;

{ TFBFloat }

function TFBFloat.AsString: string;
begin
  Result := FloatToStr(Value);
end;

{ TFBDoublePrecision }

function TFBDoublePrecision.AsString: string;
begin
  Result := FloatToStr(Value);
end;

{ TFBDate }

function TFBDate.AsString: string;
begin
  Result := FormatDateTime('dd.mm.yyyy', Value);
end;

end.
