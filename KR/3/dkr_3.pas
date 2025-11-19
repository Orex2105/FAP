function Simpson(f: real -> real; a, b: real; n: integer): real;
begin
  if n mod 2 <> 0 then
    raise new Exception('n должно быть четным');
  
  var h := (b - a) / n;
  var x := new real[n+1];
  var y := new real[n+1];
  
  for var i := 0 to n do
    x[i] := a + i * h;
  
  foreach var i in 0..n do
    y[i] := f(x[i]);
  
  var total := y[0] + y[n];
  
  foreach var i in 1..n-1 do
    if i mod 2 = 1 then
      total += 4 * y[i]
    else
      total += 2 * y[i];
  
  Result := (h / 3) * total;
end;

function Area(a, b: real; n: integer): real;
begin
  var f: real -> real := x -> Max(2*x*x*x - x*x + x + 2, 0);
  Result := Simpson(f, a, b, n);
end;

begin
  while True do
  begin
    Println('1 — Вычислить площадь');
    Println('2 — Оценить погрешность');
    Println('3 — Выход');
    Print('Выберите пункт: ');
    
    var cmd := ReadlnString();
    
    case cmd of
      '1':
        begin
          Print('a = ');
          var a := ReadlnReal();
          Print('b = ');
          var b := ReadlnReal();
          Print('n (четное) = ');
          var n := ReadlnInteger();
          
          Println('Площадь = ', Area(a, b, n));
        end;
      '2':
        begin
          Print('a = ');
          var a := ReadlnReal();
          Print('b = ');
          var b := ReadlnReal();
          Print('n (четное) = ');
          var n := ReadlnInteger();
          
          var s1 := Area(a, b, n);
          var s2 := Area(a, b, 2 * n);
          Println('Погрешность ≈ ', Abs(s2 - s1));
        end;
      '3': break;
    end;
  end;
end.