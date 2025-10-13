uses math;

procedure task_two(start_: real; end_: integer; step: real; func: real -> real);
begin
  writeln('|   x   |   y   |');
  writeln('¦---------------¦');
  
  var x := start_;
  while x <= end_ do
  begin
    var y := func(x);
    writeln('¦', x:6:2, ' |', y:7:2, '¦');
    x += step;
  end;
  
  writeln('¦---------------¦');
end;


function task_one(x: integer): real;
begin
  var func: real -> real;
  var doTaskTwo: string := 'n';
  
  if x < -9 then
  begin
    func := x -> ln(x) / (x*x);
    writeln(func(x));
  end
  else if (x >= -9) and (x < -2) then
  begin
    func := x -> power(x, 1/3) * x * (-1);
    writeln(func(x));
  end
  else if (x >= -2) and (x < 4) then
  begin
    func := x -> ln(x) + power(x, 0.1*x);
    writeln(func(x));
  end
  else if (4 <= x) then
  begin
    func := x -> ln(x) / sqr(x);
    writeln(func(x));
  end
  else
    func := x -> 0;
  
  writeln('Выполнить второе задание? (y/n, default - n)');
  readln(doTaskTwo);
  if doTaskTwo = 'y' then
    task_two(-11, 6, 0.2, func);
end;


begin
  writeln(task_one(5));
end.