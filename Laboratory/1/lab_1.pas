uses math;

procedure task_two(start_: real; end_: integer; step: real; f: real -> real);
begin
  writeln('|   x   |   y   |');
  writeln('¦---------------¦');
  
  var x := start_;
  while x <= end_ do
  begin
    var y := f(x);
    writeln('¦', x:6:2, ' |', y:7:2, '¦');
    x += step;
  end;
  
  writeln('¦---------------¦');
end;


function task_one(x: integer): real;
begin
  var func: real -> real;
  
  if x < -9 then
  begin
    func := x -> ln(x) / (x*x)
  end
  else if (x >= -9) and (x < -2) then
  begin
    func := x -> power(x, 1/3) * x * (-1)
  end
  else if (x >= -2) and (x < 4) then
  begin
    func := x -> ln(x) + power(x, 0.1*x)
  end
  else if (4 <= x) then
  begin
    func := x -> ln(x) / sqr(x)
  end
  else
    func := x -> 0;
  
  task_two(-11, 6, 0.2, func);
end;


begin
  task_one(5);
end.