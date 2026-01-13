function factorial(n: integer): integer;
begin
  if n = 1 then
  begin
    Result := 1;
    exit;
  end;
  
  Result := n * factorial(n-1);
end;

begin
  Print(factorial(5))
end.