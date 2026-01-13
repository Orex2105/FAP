procedure One(start: integer); // Параметризация
begin
  // \* База рекурсии
  if start = 0 then
  begin
    Print(0);
    exit;
  end;
  // \* База рекурсии
  
  Print(start);
  One(start-2); // Декомпозиция
end;

function sumTo(n: integer): integer; // Параметризация
begin
  // \* База рекурсии
  if n = 1 then
  begin
    Result := 1;
    exit;
  end;
  // \* База рекурсии
  
  Result := n + sumTo(n-1); // Декомпозиция
end;

function Pwr(x, y: integer): integer; // Параметризация
begin
  // \* База рекурсии
  if y = 0 then
  begin
    Result := 1;
    exit;
  end;
  // \* База рекурсии
  
  Result := x * Pwr(x, y-1) // Декомпозиция
end;

procedure LoopFor(i, n: integer); // Параметризация
begin
  Println($'Привет [{i}]');
  
  // \* База рекурсии
  if i = n then
    exit;
  // \* База рекурсии
  
  LoopFor(i+1, n); // Декомпозиция
end;

function EuclideanAlg(n1, n2: integer): integer; // Параметризация
begin
  var rem := n1 mod n2;
  
  // \* База рекурсии
  if rem = 0 then
  begin
    Result := n2;
    exit;
  end;
  // \* База рекурсии

  Result := EuclideanAlg(n2, rem); // Декомпозиция
end;

procedure fib(i, n: integer); // Параметризация
begin
  // \* База рекурсии
  if n = 89 then
    exit;
  // \* База рекурсии
  
  var newFib := i + n;
  Print(newFib);
  fib(n, newFib); // Декомпозиция
end;

begin
  //One(20);
  PrintLn(sumTo(3));
  //Println(Pwr(2, 10));
  //LoopFor(1, 10);
  //Print(EuclideanAlg(244, 18));
  //fib(0, 1);
end.