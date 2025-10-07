procedure one();
begin
  var n := readinteger();

  writeln('Число' + #9 + 'Квадрат');
  for var i := 1 to n do
  begin
    if i mod 2 <> 0 then
      writeln(i + #9 + sqr(i));
  end;
end;


procedure two();
begin
  var (a, b, c) := readreal3();
  var counter := 0;
  
  while a >= c do
  begin
    if counter <> 0 then
      a += a / 100 * 15;
    a -= b;
    counter += 1;
  end;
  
  writeln(counter);
end;


procedure three();
begin
  var segments_coords: array of (integer, integer);
  var a, b, n, point: integer;
  var points: array of integer;
  var segments_count: array[0..3] of integer;
  
  setlength(segments_coords, 4);
  for var i := 0 to 3 do
  begin
    readln(a);
    readln(b);
    segments_coords[i] := (a, b);
  end;
  
  readln(n);
  setlength(points, n);
  for var i := 0 to n-1 do
    readln(points[i]);
  
  for var i := 0 to 3 do
    segments_count[i] := 0;
  
  for var i := 0 to n-1 do
  begin
    point := points[i];
    for var j := 0 to 3 do
    begin
      if (segments_coords[j].item1 <= point) and (point <= segments_coords[j].item2) then
        segments_count[j] := segments_count[j] + 1;
    end;
  end;
  
  for var i := 0 to 3 do
  begin
    write(segments_count[i], ', ');
  end;
end;

begin
  //one();
  //two();
  three();
end.