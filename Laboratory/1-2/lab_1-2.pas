procedure one();
begin
  var x1, y1, z1: integer;
  var x2, y2, z2 : integer;
  
  read(x1, y1, z1);
  read(x2, y2, z2);
  
  var day_1 := x1*5 + y1*7 + z1*8;
  var day_2 := x2*5 + y2*7 + z2*8;
  var total := day_1 + day_2;
  
  writeln('В первый день:' + day_1);
  writeln('Во второй день:' + day_2);
  writeln('За два дня:' + total);
end;

procedure two();
begin
  var n := readinteger();
  var entrance, floor: integer;
  
  entrance := ((n - 1) div 36) + 1;
  floor := (((n mod 36) - 1) div 4) + 1;
  
  writeln('Подъезд: ' + entrance);
  writeln('Этаж: ' + floor);
end;

procedure three();
begin
  var n := readstring();
  var r_n: string;
  
  setlength(r_n, length(n));
  
  for var i:=1 to length(n) do
    r_n[i] := n[length(n)-i + 1];
 
  if r_n = n then
    writeln('Палиндром')
  else
    writeln('Не палиндром');
end;

procedure four();
begin
  var x1, y1, x2, y2: integer;
  read(x1, y1, x2, y2);
  
  if (x1 = x2) or (y1 = y2) then
    writeln('Бьет')
  else
    writeln('Не бьет');
end;

procedure five();
begin
  var (x, y, k) := readinteger3();
  var count := 0;

  var volumes := arrrandom(x, 0, 20);
  writeln(volumes);
  
  for var i := 0 to volumes.high do
    if volumes[i] = y then
      inc(count);
  
  print(count >= k ? 'Yes' : 'No');
end;

begin
 // one();
  //two();
  //three();
  four();
  five();
end.