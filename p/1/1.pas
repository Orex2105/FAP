procedure one;
begin
  var (n, p) := (ReadInteger, 1);
  var a: integer;
  
  while n <> 0 do
  begin
    a := n mod 10;
    p *= a;
    n := n div 10;
  end;
  
  Println(p);
end;


procedure two;
begin
  var (x, k, n) := (1, 0, readinteger);
  
  while x <= n do
  begin
    if n mod x = 0 then
      k += 1;
    x += 1;
  end;
  Println(k);
end;


procedure three;
begin
  var (n, x, s) := (readinteger, 1, 0);
  while x <= n do
  begin
    if n mod x = 0 then
      s += x;
    x += 1;
  end;
  if s = n then
    Println('ДА')
  else
    Println('НЕТ');
end;


procedure four;
begin
  var (i, k, n) := (1, 0, ReadInteger('Введите n: '));
  var x, c, y: integer;
  
  while i <= n do
  begin
    (x, c) := (1, 0);
    y := ReadInteger('Введите y: ');
    
    while x <= y do
    begin
      if y mod x = 0 then
        c += 1;
      x += 1;
    end;
    
    if c = 2 then
      k += 1;
    i += 1;
  end;
  
  Println(k);
end;


function is_perfect_num(num: integer): boolean;
begin
  var total := 1;
  
  for var i := 2 to round(sqrt(num))+1 do
  begin
    if num mod i = 0 then
      total += i + (num div i);
  end;
  Result := total = num;
end;

procedure five;
begin
  var n := ReadInteger('Введите количество элементов массива');
  var arr := ReadArrInteger(n);
  
  Println(arr.Where(x -> is_perfect_num(x)).Product);
end;


begin
  five;
end.