(* SimpleCalculator ***********************************************)
(* Copyright (c) 2003 Marc-Andre Lamothe ***************************)
(* All rights reserved *********************************************)

unit UnitCalc;

interface

uses SysUtils, Math ;
     
const
  FFormat = '########0.##' ;
type
  TOperations = (oAdd, oSubstract, oMultiply, oDivide, oPower, oTotal) ;
type
  TCalc = class  
  private
    cEntry : String ;
    cCurrentOp : TOperations ;
    cMemory : Real ;
    cAwnser,
    cLastAwnser : Real ;
    cClear : Boolean ;
                        
    function GetEntry : Real ;
    procedure SetEntry (Value : Real) ; 
    function EntryIsDecimal : Boolean ;
  public
    constructor Create ;
    procedure AddNumber (Value : Byte) ; 
    procedure DelNumber ;
    procedure AddDecimal ;
    procedure ChangeSign ;
    procedure Calculate ;
    procedure Add ;
    procedure Substract ;
    procedure Multiply ;
    procedure Divide ;
    procedure Power ;
    procedure Total ;
    procedure LastAwser ;
    procedure Percentage ;
    procedure MemoryAdd ;
    procedure MemoryRecall ;
    procedure MemoryClear ;
    procedure ClearEntry ;
    procedure ClearCalc ;

    property Entry : Real read GetEntry write SetEntry ;
    property ClearNext : Boolean read cClear write cClear ;
    property Awnser : Real read cAwnser ;
  end ;

implementation

function TCalc.GetEntry : Real ;
begin
  if Length(cEntry) = 0 then
    cEntry := '0' ;
  Result := StrToFloat(cEntry) ;
end ;
                            
procedure TCalc.SetEntry (Value : Real) ;
begin
  cEntry := FormatFloat(FFormat, Value) ; 
  cClear := True ;
end ;
                          
function TCalc.EntryIsDecimal : Boolean ;
begin
  if Pos(DecimalSeparator, cEntry) > 0 then
    Result := True
  else
    Result := False ;
end ;

constructor TCalc.Create ;
begin
  cEntry := '' ;
  cCurrentOp := oTotal ;
  cMemory := 0 ;
  cAwnser := 0 ;
  cLastAwnser := 0 ;
  cClear := False ;
end ;

procedure TCalc.AddNumber (Value : Byte) ;
begin
  if Length(cEntry) > 14 then
    Exit 
  else if (Length(cEntry) = 0) or cClear then
    cEntry := IntToStr(Value)
  else
    cEntry := cEntry + IntToStr(Value) ;
  cClear := False ;
end ;

procedure TCalc.DelNumber ;
begin
  if Length(cEntry) > 0 then
    Delete(cEntry, Length(cEntry), 1) ;
end ;

procedure TCalc.AddDecimal ;
begin
  if EntryIsDecimal or (Length(cEntry) > 12) then
    Exit ;
  if (Length(cEntry) = 0) or cClear then
    cEntry := '0' + DecimalSeparator
  else
    cEntry := cEntry + DecimalSeparator ;
  cClear := False ;
end ;

procedure TCalc.ChangeSign ;
begin
  if Length(cEntry) > 0 then
  begin
    if Pos('-', cEntry) > 0 then
      Delete(cEntry, Pos('-', cEntry), 1) 
    else
      cEntry := '-' + cEntry ;
  end ;
end ;
           
procedure TCalc.Calculate ;
begin
  if Length(cEntry) > 0 then
    case cCurrentOp of
	    oAdd: cAwnser := cAwnser + StrToFloat(cEntry) ;
  	  oSubstract: cAwnser := cAwnser - StrToFloat(cEntry) ;
  	  oMultiply: cAwnser := cAwnser * StrToFloat(cEntry) ;
      oDivide: cAwnser := cAwnser / StrToFloat(cEntry) ;
      oPower: cAwnser := Math.Power(cAwnser, StrToFloat(cEntry)) ;
      oTotal: cAwnser := StrToFloat(cEntry) ;
    end ;
end ;

procedure TCalc.Add ;
begin
  Calculate ;
  cEntry := '' ;
  cCurrentOp := oAdd ;
end ;
     
procedure TCalc.Substract ;
begin
  Calculate ;      
  cEntry := '' ;
  cCurrentOp := oSubstract ;
end ;
       
procedure TCalc.Multiply ;
begin
  Calculate ;    
  cEntry := '' ;
  cCurrentOp := oMultiply ;
end ;
             
procedure TCalc.Divide ;
begin
  Calculate ;    
  cEntry := '' ;
  cCurrentOp := oDivide ;
end ;

procedure TCalc.Power ;
begin
  Calculate ;    
  cEntry := '' ;
  cCurrentOp := oPower ;
end ;

procedure TCalc.Total ;
begin
  if Length(cEntry) = 0 then
    cEntry := FormatFloat(FFormat, cAwnser) ;
  Calculate ;   
  cEntry := '' ;
  cCurrentOp := oTotal ;   
  cLastAwnser := cAwnser ;
end ;

procedure TCalc.LastAwser ;
begin
  cClear := True ;
  cEntry := FormatFloat(FFormat, cLastAwnser) ;
end ;
                                
procedure TCalc.Percentage ;
begin
  if Length(cEntry) > 0 then
  begin
    cClear := True ;
    cEntry := FormatFloat(FFormat, (StrToFloat(cEntry)/100)*cAwnser) ;
  end ;
end ;

procedure TCalc.MemoryAdd ;
begin
  if Length(cEntry) > 0 then
  begin
    cMemory := cMemory + StrToFloat(cEntry) ;
    cClear := True ;
  end
  else
  begin
    cMemory := cMemory + cLastAwnser ;
    cClear := True ;
  end ;
end ;

procedure TCalc.MemoryRecall ;
begin
  cEntry := FormatFloat(FFormat, cMemory) ;
  cClear := True ;
end ;

procedure TCalc.MemoryClear ;
begin
  cMemory := 0 ;
end ;

procedure TCalc.ClearEntry ;
begin
  cEntry := '' ;
end ;
        
procedure TCalc.ClearCalc ;
begin
  cEntry := '' ;
  cCurrentOp := oTotal ;
  cAwnser := 0 ;
end ;

end.
